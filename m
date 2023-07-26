From: Shyam Saini <shyamsaini@linux.microsoft.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [RFC, PATCH 1/1] rpmb: add Replay Protected Memory Block (RPMB) driver
Date: Wed, 26 Jul 2023 20:10:16 +0000
Message-ID: <e727c5c9-58c1-5d14-99c1-5d9a62998b5@linux.microsoft.com>
In-Reply-To: <233853ab-235b-d4dd-cd69-588d1a83ce4f@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3237362110522225239=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3237362110522225239==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



Hi Randy,

Thank you for the reviews.

> Hi--
>
> On 7/21/23 18:40, Shyam Saini wrote:
>> diff --git a/drivers/rpmb/Kconfig b/drivers/rpmb/Kconfig
>> new file mode 100644
>> index 000000000000..f2a9ebdc4435
>> --- /dev/null
>> +++ b/drivers/rpmb/Kconfig
>> @@ -0,0 +1,11 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2015-2019, Intel Corporation.
>> +
>> +config RPMB
>> +	tristate "RPMB partition interface"
>> +	help
>> +	  Unified RPMB partition interface for RPMB capable devices such as
>> +          eMMC and UFS. Provides interface for in kernel security control=
lers to
>
> Indent the line above with one tab + 2 spaces instead of many spaces.
>> +	  access RPMB partition.
>> +
>> +	  If unsure, select N.
>
> Do we want a separate subdir in drivers/ for various "misc" drivers?
> with only one driver in it?
>
> Will there be other drivers in rpmb?
>

There may be others as the usage of rpmb driver grow over time but for=20
now, this is the only  driver.
Should i keep it like this ?[A

Thanks,
Shyam


--===============3237362110522225239==--

