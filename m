From: Jarkko Sakkinen <jarkko@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v8 1/4] KEYS: trusted: Add generic trusted keys framework
Date: Fri, 12 Feb 2021 14:22:06 +0200
Message-ID: <YCZy7mZ0yBPRSm9E@kernel.org>
In-Reply-To: <f51409f7-05b4-31b6-f1c5-d9e6d7c0bb46@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9221644314115944501=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============9221644314115944501==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Thu, Feb 11, 2021 at 11:34:21AM +0100, Ahmad Fatoum wrote:
> Hello Jarkko,
> 
> On 10.02.21 18:00, Jarkko Sakkinen wrote:
> > On Tue, Nov 03, 2020 at 09:31:43PM +0530, Sumit Garg wrote:
> >> +	case Opt_new:
> >> +		key_len = payload->key_len;
> >> +		ret = static_call(trusted_key_get_random)(payload->key,
> >> +							  key_len);
> >> +		if (ret != key_len) {
> >> +			pr_info("trusted_key: key_create failed (%d)\n", ret);
> >> +			goto out;
> >> +		}
> > 
> > This repeats a regression in existing code, i.e. does not check
> > "ret < 0" condition. I noticed this now when I rebased the code
> > on top of my fixes.
> > 
> > I.e. it's fixed in my master branch, which caused a merge conflict,
> > and I found this.
> 
> Does that mean this series will go out for the next merge window?
> Can you point me where your git tree is, so I can rebase on top?

No I mean the bug that is propagated here is fixed in my master
branch, i.e. get_random() should check also '< 0' condition.

/Jarkko

--===============9221644314115944501==--

