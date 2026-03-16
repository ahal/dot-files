#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.12"
# dependencies = ["tomli_w"]
# ///

import json
import subprocess
import tempfile
import tomllib
from pathlib import Path

import tomli_w

srcdir = Path("/home/ahal/dev/firefox")
sitedir = srcdir / "python" / "sites"
pyright_config = srcdir / "pyrightconfig.json"
ty_config = srcdir / "ty.toml"

with tempfile.NamedTemporaryFile("w", delete_on_close=False) as fp:
    fp.close()

    for site in sitedir.iterdir():
        print(f"Parsing {site}")
        site_name = site.stem

        cmd = [
            f"{srcdir}/mach",
            "python",
            "--virtualenv",
            site_name,
            "-c",
            f"import sys; fh = open('{fp.name}', 'a'); fh.write('\\n'.join(sys.path)); fh.close()",
        ]
        subprocess.run(cmd, check=True, capture_output=True)

    with open(fp.name) as fh:
        all_paths = set(fh.read().splitlines())

all_paths = sorted([p for p in all_paths if p.startswith(srcdir.as_posix())])

pyright_json = {}
if pyright_config.is_file():
    pyright_json = json.loads(pyright_config.read_text())

pyright_json["extraPaths"] = all_paths
pyright_config.write_text(json.dumps(pyright_json, sort_keys=True, indent=2))

ty_json = {}
if ty_config.is_file():
    ty_json = tomllib.loads(ty_config.read_text())

ty_json.setdefault("environment", {})["extra-paths"] = all_paths
ty_config.write_text(tomli_w.dumps(ty_json))
