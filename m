From: Joakim Bech <joakim.bech@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: OP-TEE development
Date: Wed, 23 Sep 2020 13:30:33 +0200
Message-ID: <20200923113033.GA32573@goby>
In-Reply-To: <=?utf-8?q?=3C01000174bab514a8-db23310d-8130-4711-aac8-b5e312f3e?=
 =?utf-8?q?1a9-000000=40email=2Eamazonses=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2148166230377508165=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2148166230377508165==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi Nikita,

On Wed, Sep 23, 2020 at 11:24:23AM +0000, Nikita Snetkov via OP-TEE wrote:
> Hello!
> 
> Currently, I became interested in TEE research and development. After small
> investigation, I found out your product: OP-TEE. After reading about it,
> there is a thing that still bothers me: is it possible to create an
> application which uses OP-TEE and distribute in via Google Play?
> 
For OP-TEE you typically create a pair of binaries, one binary running
on non-secure side (plain Linux environment) and one binary (Trusted
Application) running on the secure side.

Google Play hosts applications running in non-secure world, so I'd
believe that distributing the non-secure side of your feature using
Google Play is something you can do. But for the secure side, it's not
that easy, since it's usually the OEM that decide what to install and is
allowed to run on the secure side on their devices.

> -- 
> Yours faithfully,
> Nikita Snetkov

-- 
Regards,
Joakim

--===============2148166230377508165==--

