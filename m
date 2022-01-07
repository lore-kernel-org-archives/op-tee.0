From: Michael Walle <michael@walle.cc>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v3 2/2] arm64: dts: imx8m: define proper status for caam jr
Date: Fri, 07 Jan 2022 13:05:01 +0100
Message-ID: <00e083278fb4a8c96fdef564a2183600@walle.cc>
In-Reply-To: <8fa36ec0a6252db4b0c7fbbf09de5e816d634206.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8635515140704342048=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8635515140704342048==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Am 2022-01-07 12:58, schrieb Lucas Stach:
> Am Freitag, dem 07.01.2022 um 12:47 +0100 schrieb Michael Walle:
>> Hi Rouven,
>> 
>> Am 2022-01-07 10:46, schrieb Rouven Czerwinski:
>> > .. since AFAIK i.MX8M* can not be run without TF-A.
>> 
>> Are you sure? There probably aren't any boards out there
>> without TF-A, but why shouldn't it work without it?
> 
> PSCI, i.e. the only means to start the secondary CPUs, is implemented
> in TF-A, so it's very unlikely that anyone would want to run a system
> without TF-A. Also quite a bit of the lowlevel SoC initialization is
> implemented in TF-A.

Doesn't mean u-boot cannot implement PSCI; actually you doesn't need
it at all, you can still use spin tables. I just keep hearing the same
arguments for the LS1028A SoC and yet there is one board without TF-A ;)
Anyway, I admit it's rather unlikely.

-michael

--===============8635515140704342048==--

