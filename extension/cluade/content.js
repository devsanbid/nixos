document.addEventListener("input", async function (e) {
	if (e.target.tagName === "INPUT" || e.target.tagName === "TEXTAREA") {
		const input = e.target;
		const value = input.value;

		if (value.endsWith("/zzz")) {
			try {
				const clipboardText = await navigator.clipboard.readText();

				const newValue = value.slice(0, -4) + clipboardText;
				input.value = newValue;

				const inputEvent = new Event("input", { bubbles: true });
				input.dispatchEvent(inputEvent);
			} catch (err) {
				console.error("Failed to read clipboard:", err);
			}
		}
	}
});
