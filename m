From: Jerome Forissier <jerome@forissier.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: Possible OB1 bug in imx_csu.c
Date: Mon, 22 Feb 2021 11:26:02 +0100
Message-ID: <9025f921-f829-0b3b-7778-f76d55e0e58b@forissier.org>
In-Reply-To: <=?utf-8?q?=3C01000177c92fd34d-9f93a3ef-2e7a-4bae-943f-2ef12d506?=
 =?utf-8?q?f38-000000=40email=2Eamazonses=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3043098937596339881=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3043098937596339881==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi Robert,

On 2/22/21 11:01 AM, Robert Delien via OP-TEE wrote:
> Hi,
> 
> In imx_csu.c, the Central Security Unit's CSU_CSL*n* registers are set,
> configuring access privileges for different peripherals. These registers
> range from CSU_CSL0 (@ 0x021c0000) to CSU_CSL39 (@ 0x021c009c).
> 
> The different i.MX6 platform variants each have their individual tables,
> filled with sets of CSL index and register value, terminated by a sentinel
> set with the index set to -1. (the reason for the parentheses around -1
> espaces me)
> 
> in .../core/arch/arm/plat-imx/drivers/imx_csu.c:csu_init()@115, a while
> loop runs through this aforementioned table, setting the CSL registers
> according to the table. However, this loop loops on CSL index values > 0:
> while (csu_setting->csu_index *>* 0) {
>         io_write32(csu_base + (csu_setting->csu_index * 4),
>                    csu_setting->value);
> 
>         csu_setting++;
> }
> I think it should loop on CSL index values >= 0, because index 0 is a valid
> index, utilized for the PWM peripherals. (I also think csl_index is a more
> descriptive name, but that's besides the point).
> 
> I have attached a patch for his.

It does look like a genuine bug to me, but I will let the i.MX expert
comment further. Unfortunately, the OP-TEE ML strips attachments. Would
you mind creating a GitHub pull request [1] (preferred method), or send
the patch inline?

[1] https://github.com/OP-TEE/optee_os/pulls

Thanks,

-- 
Jerome

--===============3043098937596339881==--

