#!/usr/bin/python3
"""
Fabric script to generate a .tgz archive from the contents of the web_static folder
"""

from fabric.api import local
from datetime import datetime


def do_pack():
    """
    Compresses the contents of web_static folder into a .tgz archive
    Returns: Archive path if successful, None otherwise
    """
    timestamp = datetime.now().strftime("%Y%m%d%H%M%S")
    archive_name = "web_static_" + timestamp + ".tgz"
    local("mkdir -p versions")
    result = local("tar -czvf versions/{} web_static".format(archive_name))
    if result.succeeded:
        return "versions/{}".format(archive_name)
    return None
