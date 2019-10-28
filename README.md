
# Quick test

$> docker build -t build_your_own_distrib .
$> docker run -it -p 80:80 --cap-add=NET_ADMIN build_your_own_distrib bash
