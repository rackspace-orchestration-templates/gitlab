import re
import requests
from fabric.api import env, task, run, hide
from envassert import detect, file, group, package, port, process, service, \
    user
from hot.utils.test import get_artifacts


def gitlab_is_responding():
    r = requests.get("https://{}/users/sign_in".format(env.host), verify=False)
    if r.status_code == 200 and re.search("GitLab Community Edition", r.text):
        return True
    else:
        print "Oops! gitlab return status was {}.".format(r.status_code)
        return False

@task
def check():
    env.platform_family = detect.detect()

    assert port.is_listening(443), "port 443 (nginx) is not listening"
    assert port.is_listening(8080), "port 8080 (gitlab) is not listening"
    assert port.is_listening(22), "port 22 (ssh) is not listening"
    assert user.exists("git"), "there is no git user"
    assert group.is_exists("git"), "there is no git group"
    assert user.is_belonging_group("git", "git"), "user git is not in the git group"
    assert process.is_up("nginx"), "nginx is not running"
    assert process.is_up("postgres"), "postgres is not running"
    assert process.is_up("redis-server"), "redis-server is not running"
    assert service.is_enabled("nginx"), "service nginx is not enabled"
    assert service.is_enabled("gitlab"), "service gitlab is not enabled"
    assert gitlab_is_responding(), "gitlab did not respond as expected"


@task
def artifacts():
    env.platform_family = detect.detect()
    get_artifacts()
