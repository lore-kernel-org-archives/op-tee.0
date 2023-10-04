From: Jérôme Forissier <jerome.forissier@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Preparing for OP-TEE 4.0.0
Date: Wed, 04 Oct 2023 15:35:39 +0200
Message-ID: 
 <CA+NB=mZKwtaz4Mwg547XVvr485tzyEkEzKA+dBXZ9BHivjhqUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0571379155601346581=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0571379155601346581==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

[BCC all OP-TEE maintainers]

Hi OP-TEE maintainers & contributors,

OP-TEE v4.0.0 is scheduled to be released on 2023-10-20. So, now is
a good time to start testing the master branch on the various platforms
and report/fix any bugs.

The GitHub pull request for collecting Tested-by tags or any other
comments is https://github.com/OP-TEE/optee_os/pull/6341.

As usual, we will create a release candidate tag one week before the
release date for final testing.

Note that this is a major version update. We will be merging some pull
requests that may break backward compatibility in some (limited) way
just before creating the 4.0.0-rc1 tag. These pull requests have "[v4]" in
their title and can be found here:
https://github.com/OP-TEE/optee_os/pulls?q=3Dis%3Apr+is%3Aopen+in%3Atitle+%5B=
v4%5D

In addition to that you can find some additional information related to
releases here: https://optee.readthedocs.io/en/latest/general/releases.html

Regards,
--=20
Jerome Forissier

--===============0571379155601346581==--

