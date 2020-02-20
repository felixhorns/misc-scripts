# Starts jupyter lab server.
# Port is specified by --port.
# Does not open the notebook in a browser after startup (--no-browser).
# Output is logged to jupyter_lab.out.
# Process is sent to the background and is immune to hangups (nohup).
# nohup jupyter lab --no-browser --port=8888 > jupyter_lab.out &

# Virtual X backend is needed to render trees using ete3
# xvfb-run starts jupyter in a virtual X environment.
# To enable, comment the line above and uncomment the line below:
nohup xvfb-run jupyter lab --no-browser --port=8888 > jupyter_lab.out &


