From: Jérôme Forissier <jerome@forissier.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: OP-TEE MTE support
Date: Tue, 02 Aug 2022 14:58:51 +0200
Message-ID: 
 <CAA-cTWYHEYxgeEjwEUsPKB8PEKMnvwabTB0fm7J5LUMi+4YYHg@mail.gmail.com>
In-Reply-To: <=?utf-8?q?=3CVE1PR08MB4976A1A0CE0D3E0C4C30184B9B899=40VE1PR08MB?=
 =?utf-8?q?4976=2Eeurprd08=2Eprod=2Eoutlook=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8254881615879837586=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8254881615879837586==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi Olivier,

On Wed, Jul 13, 2022 at 3:39 PM Olivier Deprez <Olivier.Deprez@arm.com>
wrote:

> Hi,
>
> (in context of testing MTE support when OP-TEE is loaded as a secure
> partition on top of SEL2/Hafnium)
>
> I appreciate MTE support is fresh starting with v3.18, bear with me if I
> missed details:
>
> 1/ noticed using both CFG_TA_PAUTH=y CFG_MEMTAG=y (if permitted) may break
> the build
>
> diff --git a/core/tee/tee_svc.c b/core/tee/tee_svc.c
> index 03bb174a..59f8afae 100644
> --- a/core/tee/tee_svc.c
> +++ b/core/tee/tee_svc.c
> @@ -365,7 +365,7 @@ const struct tee_props tee_propset_tee[] = {
>                 .name =
> "org.trustedfirmware.optee.cpu.feat_pauth_implemented",
>                 .prop_type = USER_TA_PROP_TYPE_BOOL,
>                 .get_prop_func = get_prop_feat_pauth_implemented
> -       }
> +       },
>  #endif
>  #if MEMTAG_IS_ENABLED
>         {
>

Thanks for reporting, addressed in
https://github.com/OP-TEE/optee_os/pull/5467. Feel free to give a
Reported-by: if you want.

-- 
Jerome

--===============8254881615879837586==--

