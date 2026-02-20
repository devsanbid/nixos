# Jupyter Notebook with Vim Motions
{ pkgs, ... }: 

let
  # Python environment with Jupyter and common data science packages
  # pythonWithJupyter = pkgs.python3.withPackages (ps: with ps; [
  #   # Jupyter core
  #   jupyter
  #   jupyterlab
  #   notebook
  #   ipykernel
  #   ipywidgets
  #
  #   # Vim motions for Jupyter
  #   jupyterlab-vim
  #
  #   # Common data science packages
  #   numpy
  #   pandas
  #   matplotlib
  #   seaborn
  #   scipy
  #   scikit-learn
  #
  #   # Additional useful packages
  #   plotly
  #   nbformat
  #   nbconvert
  # ]);
in
{
  environment.systemPackages = with pkgs; [
    # Python with Jupyter and packages
    # pythonWithJupyter
    
    # JupyterLab desktop app (optional)
    # jupyterlab-desktop
  ];

  # Jupyter configuration for vim motions
  # After installation, enable vim motions in JupyterLab:
  # 1. Open JupyterLab
  # 2. Go to Settings -> Settings Editor
  # 3. Search for "vim" and enable jupyterlab-vim
  # 
  # Or run: jupyter labextension enable @axlair/jupyterlab_vim
  #
  # For classic notebook vim bindings, you can also use:
  # pip install jupyter-vim-binding (in a user environment)
}
