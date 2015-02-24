from fabric.api import env, task
from envassert import detect, file, group, package, port, process, service, \
    user
from hot.utils.test import get_artifacts


@task
def check():
    env.platform_family = detect.detect()

    assert package.installed("nginx"), "package nginx is not installed"
    assert package.installed("mysql-server-5.5"), "package mysql-server-5.5 is not installed"
    assert file.exists(
        "/srv/git/gitlab/vendor/bundle/ruby/1.9.1/bin/unicorn_rails"), "unicorn is not configured"
    assert file.exists("/srv/git/bin/ruby"), "ruby is not installed"
    assert port.is_listening(80), "port 80 is not listening"
    assert port.is_listening(443), "port 443 is not listening"
    assert port.is_listening(3306), "port 3306 is not listening"
    assert port.is_listening(6379), "port 6379 is not listening"
    assert user.exists("git"), "there is no git user"
    assert group.is_exists("git"), "there is no git group"
    assert user.is_belonging_group("git", "git"), "user git is not in the git group"
    assert process.is_up("nginx"), "nginx is not running"
    assert process.is_up("mysqld"), "mysqld is not running"
    assert process.is_up("redis-server"), "redis-server is not running"
    assert service.is_enabled("nginx"), "service nginx is not enabled"
    assert service.is_enabled("mysqld"), "service mysqld is not enabled"
    assert service.is_enabled("gitlab"), "service gitlab is not enabled"


@task
def artifacts():
    env.platform_family = detect.detect()
    get_artifacts()
