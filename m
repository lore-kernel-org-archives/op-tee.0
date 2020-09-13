From: Markus Elfring <Markus.Elfring@web.de>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee/tee_shm.c: Fix error handling path
Date: Sun, 13 Sep 2020 10:30:21 +0200
Message-ID: <641dfe3b-1de8-97ea-eac7-89d81846eab3@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4435405216806640743=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4435405216806640743==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

> When shm->num_pages <= 0, we should avoid calling
> release_registered_pages() in error handling path.

* Would an imperative wording become helpful for the change description?

* I suggest to add the tag “Fixes” to the commit message.

Regards,
Markus

--===============4435405216806640743==--

