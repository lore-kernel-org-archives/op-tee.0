From: Jonathan Corbet <corbet@lwn.net>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] docs: staging/tee.rst: convert into definition list
Date: Thu, 23 Jul 2020 14:25:17 -0600
Message-ID: <20200723142517.4a6e17c5@lwn.net>
In-Reply-To: <20200718165107.625847-4-dwlsalmeida@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3088545984047248592=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3088545984047248592==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 18 Jul 2020 13:50:58 -0300
"Daniel W. S. Almeida" <dwlsalmeida@gmail.com> wrote:

>  TEE bus infrastructure registers following APIs:
> --  match(): iterates over the client driver UUID table to find a correspon=
ding
> -   match for device UUID. If a match is found, then this particular device=
 is
> -   probed via corresponding probe API registered by the client driver. This
> -   process happens whenever a device or a client driver is registered with=
 TEE
> -   bus.
> --  uevent(): notifies user-space (udev) whenever a new device is registere=
d on
> -   TEE bus for auto-loading of modularized client drivers.
> +
> +match():
> +  iterates over the client driver UUID table to find a corresponding
> +  match for device UUID. If a match is found, then this particular device =
is
> +  probed via corresponding probe API registered by the client driver. This
> +  process happens whenever a device or a client driver is registered with =
TEE
> +  bus.
> +
> +uevent():
> +  notifies user-space (udev) whenever a new device is registered on
> +  TEE bus for auto-loading of modularized client drivers.

Just FWIW, this could have been fixed by adding a blank line between the
two bulleted entries.  This fix is fine too, though, applied, thanks.

jon

--===============3088545984047248592==--

