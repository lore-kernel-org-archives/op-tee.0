From: Lucas Stach <l.stach@pengutronix.de>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v3 2/2] arm64: dts: imx8m: define proper status for caam jr
Date: Fri, 07 Jan 2022 12:58:58 +0100
Message-ID: <8fa36ec0a6252db4b0c7fbbf09de5e816d634206.camel@pengutronix.de>
In-Reply-To: <4ed84dc354eee36067ade567097ddd68@walle.cc>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4858042062066271049=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4858042062066271049==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Am Freitag, dem 07.01.2022 um 12:47 +0100 schrieb Michael Walle:
> Hi Rouven,
> 
> Am 2022-01-07 10:46, schrieb Rouven Czerwinski:
> > .. since AFAIK i.MX8M* can not be run without TF-A.
> 
> Are you sure? There probably aren't any boards out there
> without TF-A, but why shouldn't it work without it?

PSCI, i.e. the only means to start the secondary CPUs, is implemented
in TF-A, so it's very unlikely that anyone would want to run a system
without TF-A. Also quite a bit of the lowlevel SoC initialization is
implemented in TF-A.

Regards,
Lucas


--===============4858042062066271049==--

