FROM registry.gitlab.com/islandoftex/images/texlive:latest

COPY ./texlive-packages.txt /tmp/
RUN tlmgr update --self && \
    tlmgr install $(grep -vE '^\s*#' /tmp/texlive-packages.txt | tr '\n' ' ')

COPY ./.latexmkrc /root/.latexmkrc
