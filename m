From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Linaro OP-TEE Contribution, LOC, monthly meeting September 24
Date: Mon, 23 Sep 2024 10:20:24 +0200
Message-ID: 
 <CAHUa44GkZ93GETAKV9G6p6v132=rdVSoQjXb-h8fcE_OMxQFTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8282532678393017323=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8282532678393017323==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi,

Tomorrow, Tuesday, it's time for another LOC monthly meeting. For time
and connection details see the calendar at
https://www.trustedfirmware.org/meetings/

I've started to work on importing the TA specific part of fTPM into
the OP-TEE git, based on the patches published at
https://github.com/zeschg/ms-tpm-20-ref/tree/feat_add_tee_crypto
replacing the third-party crypto library with TEE Internal core API.
I'd appreciate help reviewing this when I publish the work.

We'll need a way to test that the imported fTPM implementation works
as expected, preferably something we can have in our CI loop.

Are there any other topics?

Cheers,
Jens

--===============8282532678393017323==--

