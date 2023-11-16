From: Jan Claußen <jan.claussen10@web.de>
To: op-tee@lists.trustedfirmware.org
Subject: Re: How to sign TAs with an HSM?
Date: Thu, 16 Nov 2023 13:26:25 +0100
Message-ID: <73DDF5E9-B39C-4321-AA68-FE9EDE1D65B7@getmailspring.com>
In-Reply-To: <
 <CAFA6WYP=N27Up=02Jc=sf3Mtz3VGH0apAESuVnJNzztTVCkmkw@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6058932580541958728=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6058932580541958728==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

@J=C3=A9rome You solution worked well. Thank you!

@=C3=89tienne It works for me now, so actually there is no need for me. I als=
o think that for the sake of transparency, it is letting the signing step be =
done by official tools like openssl or pkcs11-tool is the better solution! It=
 would just be great if the documentation could be changed accordingly.
Make clear that the pubkey must be used for the digest and stitch steps
Fix the pkcs11-tool command example

Maybe mention that the --ta-version flag must be set for some TAs e.g. oemcry=
pto. This has taken me quite a while to find out. Had to look at the make com=
mands in Yocto.

Cheers,
Jan

--===============6058932580541958728==--

