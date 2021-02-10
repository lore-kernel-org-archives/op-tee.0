From: Jarkko Sakkinen <jarkko@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v8 1/4] KEYS: trusted: Add generic trusted keys framework
Date: Wed, 10 Feb 2021 19:00:46 +0200
Message-ID: <YCQRPo0o6MZ0pcUa@kernel.org>
In-Reply-To: <1604419306-26105-2-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3483289443282108897=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3483289443282108897==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Tue, Nov 03, 2020 at 09:31:43PM +0530, Sumit Garg wrote:
> +	case Opt_new:
> +		key_len = payload->key_len;
> +		ret = static_call(trusted_key_get_random)(payload->key,
> +							  key_len);
> +		if (ret != key_len) {
> +			pr_info("trusted_key: key_create failed (%d)\n", ret);
> +			goto out;
> +		}

This repeats a regression in existing code, i.e. does not check
"ret < 0" condition. I noticed this now when I rebased the code
on top of my fixes.

I.e. it's fixed in my master branch, which caused a merge conflict,
and I found this.

/Jarkko

--===============3483289443282108897==--

