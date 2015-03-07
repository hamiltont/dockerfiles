1. When using multiple processes inside a container, I always opt for a
process monitor like supervisord instead of bash. This is because 
bash doesn't propagate signals like SIGTERM to child processes and
therefore they don't get a chance to shut down cleanly. This can be
done with bash (see https://veithen.github.io/2014/11/16/sigterm-propagation.html)
but it's quite tricky for multiple processes.
