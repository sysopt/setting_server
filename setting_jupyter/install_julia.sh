cd

wget https://julialang-s3.julialang.org/bin/linux/x64/1.8/julia-1.8.3-linux-x86_64.tar.gz

tar zxvf julia-1.8.3-linux-x86_64.tar.gz

echo 'export PATH="$PATH:/home/$USER/julia-1.8.3/bin"' >> ~/.bashrc

source ~/.bashrc
