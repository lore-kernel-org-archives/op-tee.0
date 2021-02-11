From: Ahmad Fatoum <a.fatoum@pengutronix.de>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v8 1/4] KEYS: trusted: Add generic trusted keys framework
Date: Thu, 11 Feb 2021 11:34:21 +0100
Message-ID: <f51409f7-05b4-31b6-f1c5-d9e6d7c0bb46@pengutronix.de>
In-Reply-To: <YCQRPo0o6MZ0pcUa@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7148001825278881295=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7148001825278881295==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hello Jarkko,

On 10.02.21 18:00, Jarkko Sakkinen wrote:
> On Tue, Nov 03, 2020 at 09:31:43PM +0530, Sumit Garg wrote:
>> +	case Opt_new:
>> +		key_len = payload->key_len;
>> +		ret = static_call(trusted_key_get_random)(payload->key,
>> +							  key_len);
>> +		if (ret != key_len) {
>> +			pr_info("trusted_key: key_create failed (%d)\n", ret);
>> +			goto out;
>> +		}
> 
> This repeats a regression in existing code, i.e. does not check
> "ret < 0" condition. I noticed this now when I rebased the code
> on top of my fixes.
> 
> I.e. it's fixed in my master branch, which caused a merge conflict,
> and I found this.

Does that mean this series will go out for the next merge window?
Can you point me where your git tree is, so I can rebase on top?

> 
> /Jarkko
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel(a)lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--===============7148001825278881295==--

