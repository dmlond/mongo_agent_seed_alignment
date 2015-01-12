FROM dmlond/bwa_plasmodium_data
MAINTAINER Darin London <darin.london@duke.edu>

USER root
RUN ["/usr/bin/yum", "install", "-y", "--nogpgcheck", "libyaml", "libyaml-devel", "tar", "make", "gcc", "readline", "readline-devel", "openssl","openssl-devel","libxml2-devel","libxslt","libxslt-devel"]
ADD install_ruby.sh /root/install_ruby.sh
RUN ["chmod", "u+x", "/root/install_ruby.sh"]
RUN ["/root/install_ruby.sh"]
RUN ["/usr/local/bin/gem", "install", "moped"]
RUN ["/usr/local/bin/gem", "install", "mongo_agent"]
ADD seed.sh /usr/local/bin/seed.sh
ADD seed_alignment.rb /usr/local/bin/seed_alignment.rb
RUN ["chmod", "777", "/usr/local/bin/seed_alignment.rb"]
RUN ["chmod", "777", "/usr/local/bin/seed.sh"]
USER bwa_user
CMD ["/usr/local/bin/seed.sh"]
