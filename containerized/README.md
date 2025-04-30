# WIP: Dockerized Development Environment?
- Idea: Full fledged neovim development environment that can be spawned up in a rootless environmnet with minimal set up.

- This includes installing LSPs for relevant languages, which means the base node/npm has to be available, need clang/cmake etc.
- Git for git stuff, fzf, curl, ripgrep, xclip, python3, tzdata
- End goal is once a container is created, the initial set up can be done on runtime instead of needing everything to be instaleld....
- 
- Questions: How to figure out which directories to attach? Maybe start with a base "work" volume that is then bound during container setup time...
- 
- Tmux and other build tools will be set up outside of the docker environment...

### Tenets:
- SPEED IS KEY 
- Stay as lightweight as possible.

### Dev Goals:
- Start with debian, figure out if alpine can be used eventually. 
- Slowly build up so that the image building process itself will build the entire IDE complete with everything.
- Also then move to CI/CD when committing to the repo
- Eventually: Potentially create language specific images for lighter version
