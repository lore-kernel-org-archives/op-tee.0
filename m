From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v8 3/4] tee: add tee_device_set_dev_groups()
Date: Tue, 13 Aug 2024 17:09:53 +0530
Message-ID: 
 <CAFA6WYNwsgLD4bYRbPPG4MqshP8cmvZ5YdvgnX6Zsoeez8b-bw@mail.gmail.com>
In-Reply-To: <20240812133127.865879-4-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1858010267936474999=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1858010267936474999==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Jens,

On Mon, 12 Aug 2024 at 19:01, Jens Wiklander <jens.wiklander@linaro.org> wr=
ote:
>
> Add tee_device_set_dev_groups() to TEE drivers to supply driver specific
> attribute groups. The class specific attributes are from now on added
> via the tee_class, which currently only consist of implementation_id.
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  drivers/misc/rpmb-core.c | 155 +++++++++++++++++++--------------------

These changes don't seem to belong to this patch but rather patch #1.

>  drivers/tee/tee_core.c   |  19 +++--

>  include/linux/rpmb.h     |  53 +++++--------

Ditto here.

-Sumit

--===============1858010267936474999==--

