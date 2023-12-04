---
title: NixOS Ocean Sprint 2023
date: '2023-12-04'
permalink: '/posts/oceansprint-2023/index.html'
tags: [nix, ocean sprint]
---

![](/images/oceansprint-2023.jpg)

This year I was able to attend the 4th Ocean Sprint, which took place in Costa Teguise on Lanzarote.

[Ocean Sprint](https://oceansprint.org/) is an amazing event run regularly by [Domen](https://github.com/domenkozar), [Nejc](https://github.com/zupo) and [Florian](https://github.com/chaoflow), where members of the NixOS community spend 5 days hacking on projects together. There are also other activities like surfing and diving which are a good break from all the programming and technical discussion.

I found the sprint to be a productive environment and a great way to meet and collaborate with other members of the NixOS community.

Here's an overview of what I worked on this sprint:

## Bypassing `sudo` as a trusted user

> Adding a user to `trusted-users` is essentially equivalent to giving that user root access to the system. For example, the user can access or replace store path contents that are critical for system security.
> — [Nix Manual](https://nixos.org/manual/nix/stable/command-ref/conf-file.html#conf-trusted-users)

Ever since discovering the `trusted-users` setting, I've wanted to build an exploit for it to make people think twice about setting themselves as a trusted user, as it effectively allows any program running as your user to become `root` without knowing your password.

I worked together with [@lheckemann](https://github.com/lheckemann) and [@tomberek](https://github.com/tomberek) on attempting to craft an exploit which would allow you to bypass typing the password for `sudo` on any NixOS system, however we were relying on a daemon command that is currently unimplemented.

We were unable to implement the desired exploit during the sprint, however stay tuned as we still have more ideas to explore in future.

## Changing `max-jobs` to `auto` in Nix

The `max-jobs` setting in Nix controls the maximum amount of jobs Nix will build in parallel. For most users, the default is `auto` as it is set by both NixOS and nix-darwin. However, the default in Nix is `1` meaning users who aren't using NixOS or nix-darwin will only be building one job at a time which is not ideal.

I had already begun working on a PR prior to the sprint. However, I had run into some C++ issues that were above my pay grade which I only managed to fix thanks to the help of [@tfc](https://github.com/tfc) and [@marijanp](https://github.com/marijanp).

## Adding a `--bundler` flag to `nix build`

After learning about the `nix bundle` subcommand from [@tomberek](https://github.com/tomberek), I thought that it would be more useful if the `--bundler` flag was available with other subcommands, rather than having its own subcommand which basically is just `nix build` with a bundler.

We were able to hack together a proof of concept implementation of adding the `--bundler` flag to `nix build` which should be easy to extend to other Nix subcommands in future.

## Running a macOS guest on an ARM macOS host

Currently, the only way to run a macOS guest inside QEMU on an ARM Mac is to use a work in progress patchset which adds `Virtualization.Framework` support to QEMU.

Currently there are a few restrictions with this patchset like only macOS Monterey being supported, the keyboard not working and the macOS installer being unsupported.

Despite all of these restrictions, I was able to build QEMU with the patchset and successfully run macOS during the sprint.

## Cross architecture support for `darwin.linux-builder`

The `darwin.linux-builder` module by [@Gabriella439](https://github.com/Gabriella439) allows macOS users to easily set up a Linux VM that can build Nix derivations on their local machine.

During the sprint, I extended the module to support running `x86_64-linux` VMs on `aarch64-linux`.

The main caveat is that the VMs are currently running through QEMU which does not support Rosetta at the moment, making them super slow.

I highly recommend anyone in the NixOS community who is thinking about going to apply for future sprints.

Thank you so much to Domen, Nejc, Florian, and all the sponsors for allowing Ocean Sprint to exist.
