#!/run/current-system/sw/bin/bash

# OpenRouter API configuration
API_KEY="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"
API_URL="https://openrouter.ai/api/v1/chat/completions"
MODEL="deepseek/deepseek-r1-0528:free"
# MODEL="openai/o1-mini-2024-09-12"            # Best accuracy/cost balance
# MODEL="openai/o1-2024-12-17"                 # Maximum accuracy (expensive)
# MODEL="anthropic/claude-sonnet-4-20250514"   # Great for explanations
# MODEL="google/gemini-pro-1.5"                # Good alternative
# MODEL="anthropic/claude-sonnet-4.5"                # Claude

get_ai_response() {
    clipboard_content=$(wl-paste)
    temp_response=$(mktemp)

    # Prepare the prompt
    prompt="${clipboard_content}\nFrom the following options, choose the single most correct answer. Do not provide any explanation or justification just show answer no other things"


    # Make API request to OpenRouter with increased max_tokens
    echo "Making API request to OpenRouter..." >&2
    curl -s -X POST "$API_URL" \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer $API_KEY" \
        -H "X-Title: Clipboard AI Assistant" \
        -d "{
            \"model\": \"$MODEL\",
            \"messages\": [
                {
                    \"role\": \"user\",
                    \"content\": $(echo "$prompt" | jq -Rs .)
                }
            ],
            \"temperature\": 0.1,
            \"max_tokens\": 500
        }" 2>/dev/null > "$temp_response"

    echo "API request completed" >&2
    echo "Response file size: $(wc -c < "$temp_response") bytes" >&2
    echo "Raw API response:" >&2
    cat "$temp_response" >&2
    echo "" >&2

    if [ -s "$temp_response" ]; then
        # Try to extract the AI response content
        ai_response=$(jq -r '.choices[0].message.content' "$temp_response" 2>/dev/null)

        # If content is empty, try to get the reasoning field (for R1 model)
        if [ -z "$ai_response" ] || [ "$ai_response" = "null" ]; then
            ai_response=$(jq -r '.choices[0].message.reasoning' "$temp_response" 2>/dev/null)
        fi


        if [ -n "$ai_response" ] && [ "$ai_response" != "null" ]; then
            dunstify -h string:bgcolor:#FFFFFF -h string:fgcolor:#ADACAD "AI Response" "$ai_response" -t 3000
        else
            # Check for error in response
            error_msg=$(jq -r '.error.message // "Failed to parse AI response"' "$temp_response" 2>/dev/null)
            dunstify "Error" "$error_msg" -t 1500
        fi
    else
        echo "No response received from the API." >&2
        dunstify "Error" "No response from OpenRouter API" -t 1500
    fi

    rm "$temp_response"
}

trap 'echo "Exiting..." >&2; exit 1' INT
get_ai_response &
