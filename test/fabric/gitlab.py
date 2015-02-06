from fabric.api import env, task
from envassert import detect, file, group, package, port, process, service, \
    user
from hot.utils.test import get_artifacts


@task
def check():
    env.platform_family = detect.detect()

    assert package.installed("nginx")
    assert package.installed("mysql-server-5.5")
    assert file.exists(
        "/srv/git/gitlab/vendor/bundle/ruby/1.9.1/bin/unicorn_rails")
    assert file.exists("/srv/git/bin/ruby")
    assert port.is_listening(80)
    assert port.is_listening(443)
    assert port.is_listening(3306)
    assert port.is_listening(6379)
    assert user.exists("git")
    assert group.is_exists("git")
    assert user.is_belonging_group("git", "git")
    assert process.is_up("nginx")
    assert process.is_up("mysqld")
    assert process.is_up("redis-server")
    assert service.is_enabled("nginx")
    assert service.is_enabled("mysqld")
    assert service.is_enabled("gitlab")


@task
def artifacts():
    env.platform_family = detect.detect()
    get_artifacts()
