Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 587FFC44507
	for <op-tee@archiver.kernel.org>; Fri, 17 Jul 2026 09:38:52 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 6C1384518B
	for <op-tee@archiver.kernel.org>; Fri, 17 Jul 2026 09:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1784281131;
	bh=gKgeA9w2lvXNBlVpC/vszCTY3PxeBizUQZBLIlohBF0=;
	h=References:In-Reply-To:Date:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=WCAdv8KAEa9rSS07d3q93wkpcEMF4gKPldAihPm/5dMGAN9vnn4HEuhFN3eW/nKHG
	 +pzkq4Sq1tQAgVox3pNGlupPxqIRXX7p8EYJi7Cb2e10kHH6hSASKAVCtaY7dhq3oT
	 cik4Hrb6ckb1LK7p1Fds/IrKoovsSgPqVJHYNKF6rZP8ZYmsiCd8YH3diXFKBJwpPA
	 Wx0Mdz7ZSGUKJ/3WfXEsopvoVQlDvKqx95FxhUwsCQgL0UehzBBisJ+nXFM0TQYL5B
	 jeiaST9MuUs1Wr+9ZqrciqUWmr5rSaz5Oy0Yo8upDqBTOpV9KTJwS1tfwllzCtqTqV
	 nKO7si7zjBULA==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 5B5FA44DBC
	for <op-tee@lists.trustedfirmware.org>; Fri, 17 Jul 2026 09:38:44 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FSkHj2RV;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Jx65yZnv;
	dkim-atps=neutral
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66H6ciuZ980050
	for <op-tee@lists.trustedfirmware.org>; Fri, 17 Jul 2026 09:38:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Byke9lF7SSp42L4/+Y+WzY4ZS/QRpxLv4f6tPfcDO5Q=; b=FSkHj2RVHfNGNFyd
	Tvxff00A7KexF3nP6J0PBeyrg+IIvYiduSLB2nZ11464CQK8gbTqV3IthCYJX76X
	FQVq6IhdeHdS7IlSJFMq1DI9E/ytGMPOfqEMgLY36JNcsVns67IPLKQ7Ue8wTFuF
	y3R3UCZ2NTHczYBRJuqPz9P4Z6Jpjt9WNBSBZlWFo52VsnsE1/Y9atJ6O/+1rAi2
	sw/xQlZe0miL+pMuOxjBN7M/E7rSVw7YddpPYRiN24bvIJxnUhxSj3pMUzA5N1+g
	DNhPoD6qVYblUiYyZhJR2L3GDcuefsLw0F3NcWo+TN6Dlzs6ZaE6jZa1WiLoOQRo
	QRjtKQ==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com [209.85.128.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fff9grpjn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Fri, 17 Jul 2026 09:38:43 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-81ea59b5979so132905257b3.3
        for <op-tee@lists.trustedfirmware.org>; Fri, 17 Jul 2026 02:38:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784281123; cv=none;
        d=google.com; s=arc-20260327;
        b=eestD1Oy/+zbvmDWMa4ZdMqwXkq4/aHKDqHKQP3rwZMky222LFeYOqDnB9VFG/Bv5W
         7KBg6vHThLIrNQi2PkDv35dNbeKS17VhufiV0OSFWkEH1QcGMkjjJRhgjddC/JdXij4Q
         jpayWpMTOsskS0DKF0xBnQXMUvBgGePsPkesuKIDJteBubS7OAVvzjmdTFIJ7RYN6wqi
         6F9OQEytcoDqjU+GuyT5Krj3MRHMUqoE2rrKrutGEUOJJucN4rNTFHCOFAQTZerSRfSE
         B3+CImqrlMnjb7gczWEuCtGVGZ5fb0J0Gx+A33uEIkzEsCVLKqGJFU8TKVyR064xc+v0
         J1kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Byke9lF7SSp42L4/+Y+WzY4ZS/QRpxLv4f6tPfcDO5Q=;
        fh=BuFgUjay9rRdUWlGApX2k/TdpeXBuXjr8Y8v9uSmj+4=;
        b=dqU536oReO66/nWGBuL/PXcZM3QnjB4z7tAHru5n5/U8utV55GXmWwQwRLZ7WScYCp
         LzwEpF7CKzpte6AoNBsJ46JALaqmrot1uK5eboqAU4PHKTMJrvgIQZND+z9ApDGJayY/
         wxnQL3OCZ6bKMsSRGuMuXzLlAV8dVpOEWzAi6dfGOoFFouW8ruZkvcfqolu0+73agSuC
         TSGv65UVrURNqquqqz5KmORmO3dXiDTwf/hkLFMS9U1M1JkEQi2eZKvQhTGNMXBlt5XR
         rxMHqbINTyinPe040m7F2TQURZNCUFWTGR7XaGHdXCFuDAPW4CDPzEDBRyullV58p+sQ
         MkCA==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784281123; x=1784885923; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Byke9lF7SSp42L4/+Y+WzY4ZS/QRpxLv4f6tPfcDO5Q=;
        b=Jx65yZnveACCQAJGRTV1f2fF1S3C3CO0UzrFol/BFg1jYN/6MAIgYzdfrVsFRNFmhI
         3sJW1e8uU5Eg9goNVIeuBP0F8F78FA94wPT0LukXke56Cpqr9UpWEbFdX6AgiUTJL8Vt
         qQeiisrvO2JsE/J3jtCjWfCLVXpN/79PkPB3Fhe70v8SYrBEo3/Hg3jBMNnADYUBzcts
         TpqhyTi2WMRvKSd9z6w8+PWSEf9hX71DkWAy+pgfXKkuZDnV9JR46Gi49m3Bgf4eUj1C
         dVlgppTxXDhyMsvEdkgVl4pT4y8QHRPqWz96uvWzXaA23l+3k6tXxi4InaLAsgTMjmFW
         gkUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784281123; x=1784885923;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Byke9lF7SSp42L4/+Y+WzY4ZS/QRpxLv4f6tPfcDO5Q=;
        b=euYSbTkmQ3CAEIRxjbtwM3zNrKxJpPVbrLKXAnMaWl0ffW5WJ1+hUSHInHWZYvowzH
         Fp3zuRuCl2grqgim3bqOjhYn/UuBXhLf0p+ZcIJISKx5QkHPu/fh04dKDxhyoxSRMmdd
         oYj+fa2dNYR/UCiQRq6y2vP0d932zrBSFxoQqJ/uSIxKmTlWqxqiMLKNzBEhr26vekkW
         uzRJhX7W7gMeCWONtA/HSR4rj/LQw4KBRsMpx9CfzfvyMPyZByttItes17BXNqK0cz8y
         /nUrWnE2IdUoq2NESuvc/CVCNdI8nwux4uSkKwkJV9N5GC67+CGojQsAksV8ccAQiKWa
         k7pQ==
X-Forwarded-Encrypted: i=1; AHgh+RoV71c8DL45mutkjrbKTVuQ1E9MAyzDzk/9GcKo+HJacNn7+84X4X9c8WTt67wibRbUPINQ4M8=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwgKJLs74GJcm7DfaElQwqWgNKcpwPLLCIUHfQGD4K9hZxypKYT
	7bb58ul2MS5Eou8Pg21kvcdfQsYOe6l31IVtSB9u3bwPu+kfpEfyLIkwku02cn1A8MWQUSiKHKN
	bSpkN5L5S0Eo+woFWXNVO0LK/4DLTGAplTh/+naGvbJoesEmsFxYMd8YkEn5pi9BzvqKeIzO+5/
	cb2Q9SSAnBS/0pZAhkYESd6AqjknYs2cjgajXoUtKHMcmVSvM=
X-Gm-Gg: AfdE7clAFveRjQvIkCFPgJAdJmOFZf3f+RqCcTWVWfB7MzWOoSQv1opbdx20s8om8aL
	OoB3F/ouOAF8JXT9WF7JkxFeVbfonbZMZpW0OTyRiMi0cNd0kaY12F1ayZwe3V4ZIIwJxXOc1bO
	vD8AaIM2nNOVMmAwnPwGq0oxxhN51gH/ta1zR35sff4IDhT7f2Wuxoei8=
X-Received: by 2002:a05:690e:13ce:b0:667:daee:17ee with SMTP id 956f58d0204a3-6683bb79a33mr442041d50.39.1784281122910;
        Fri, 17 Jul 2026 02:38:42 -0700 (PDT)
X-Received: by 2002:a05:690e:13ce:b0:667:daee:17ee with SMTP id
 956f58d0204a3-6683bb79a33mr442029d50.39.1784281122363; Fri, 17 Jul 2026
 02:38:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260716083728.2226422-1-jorge.ramirez@oss.qualcomm.com> <20260716083728.2226422-3-jorge.ramirez@oss.qualcomm.com>
In-Reply-To: <20260716083728.2226422-3-jorge.ramirez@oss.qualcomm.com>
Date: Fri, 17 Jul 2026 11:38:31 +0200
X-Gm-Features: AUfX_mxVDZM5kXu-CrAEkInMj0hjSBk8LzLzD_taXmZkxBvbyWjLlJY_ZY3mexE
Message-ID: <CAGgiveXtErFjDgxN9reR7s705U3wnnH65c4Su06ZQz_7EYwzuA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] ufs: rpmb: use a fixed-length RPMB dev_id
To: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDA5NiBTYWx0ZWRfXwqqU0Oc0f5Kg
 81CMlcn+cF24njDNDInQWHyGEujWt9SAH6nNXURKmksWrOmZGXcm6YcR3lVz49unkoJHbq8FHzC
 F36MJhUzT/4HfEfTID+Q/w1OqzXUuEw=
X-Proofpoint-ORIG-GUID: 2YJOy6rxUuAT9rKo-3JkwHKamFj60vLy
X-Proofpoint-GUID: 2YJOy6rxUuAT9rKo-3JkwHKamFj60vLy
X-Authority-Analysis: v=2.4 cv=TaumcxQh c=1 sm=1 tr=0 ts=6a59f823 cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8
 a=xHNurQw6US8NauEldhQA:9 a=QEXdDO2ut3YA:10 a=kLokIza1BN8a-hAJ3hfR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDA5NiBTYWx0ZWRfX7phc1l3QFkM5
 Htfhl8BRS3DcTF61JapR5Amx3ZK+QHCTHyLWTmTiZ2Z/M3D1bOcSw7e62dpy3xm1454WuxEcdiD
 t+Ul+d3YOF/Ojba6DRmmRgqId3nahM9T6aX5KPOn9IuTY0pnsryx6VPwI95J/Rs2GeHvZ3PUIyY
 U163UCrtMyk1FBPiRBW+A47qETq5cLRSYabiOOU+85O4sFGLdeRlPlpxfI+3RUk9YfsMvSHy5ue
 w+yh19sxoBBRZdTwEv5NvuIKtU+uosaEWBhcNyOJui5TxtLuZ8eSUu85HwXDRIxaxeM7sF01F7T
 jp8w3jkoCq9s4C86QX5dzbSZbths/vfWApXH7g4H5OuyH/OaWIDdShJlJJn+atv+x5yrwSR6RJ8
 oNdHnLOYad04qeWvMGhD8a0zttO0D1uJKlN50G2AGyNoJ2G7OiSLZ++s8HoNMzDI01e30ftfjhs
 6y9IuELzmezbzSGkjJQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 adultscore=0 phishscore=0
 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170096
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[google.com:s=arc-20260327:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	RCPT_COUNT_TWELVE(0.00)[13];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.200:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	ALIAS_RESOLVED(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 5B5FA44DBC
X-Spamd-Bar: -----
Message-ID-Hash: PM6SSPYDZUNBRCNI2CIOL6DWG7375ISI
X-Message-ID-Hash: PM6SSPYDZUNBRCNI2CIOL6DWG7375ISI
X-MailFrom: jens.wiklander@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org, James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com, beanhuo@micron.com, can.guo@oss.qualcomm.com, linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, jenswi@kernel.org, sumit.garg@oss.qualcomm.com
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/PM6SSPYDZUNBRCNI2CIOL6DWG7375ISI/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Jens Wiklander via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jens Wiklander <jens.wiklander@oss.qualcomm.com>

Hi Jorge,

On Thu, Jul 16, 2026 at 10:37=E2=80=AFAM Jorge Ramirez-Ortiz
<jorge.ramirez@oss.qualcomm.com> wrote:
>
> The RPMB authentication key is derived from the dev_id handed to the
> RPMB subsystem. OP-TEE implements the eMMC RPMB flow, where the dev_id
> is the eMMC CID, a fixed 16-byte value, and it derives the key on that
> assumption.
>
> The UFS RPMB id built here is "<device_id>-R<region>", which is variable
> length and longer than 16 bytes. Passing it verbatim would tie the
> derived key to a length OP-TEE does not expect and diverge from the
> fixed-CID eMMC ABI, requiring OP-TEE to be taught about variable-length
> UFS ids.

Yes, if it's possible, It's nice to avoid that.

>
> Hash the UFS id into a fixed 16-byte dev_id with blake2s instead. This
> keeps the derived key stable and unique per region while matching the
> eMMC CID layout OP-TEE relies on, so the key-derivation ABI stays
> identical and no OP-TEE change is needed.
>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
> ---
>  drivers/ufs/core/ufs-rpmb.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/ufs/core/ufs-rpmb.c b/drivers/ufs/core/ufs-rpmb.c
> index d0c7ea7a36f4..b800871269bb 100644
> --- a/drivers/ufs/core/ufs-rpmb.c
> +++ b/drivers/ufs/core/ufs-rpmb.c
> @@ -10,6 +10,7 @@
>   *     Can Guo <can.guo@oss.qualcomm.com>
>   */
>
> +#include <crypto/blake2s.h>
>  #include <linux/module.h>
>  #include <linux/device.h>
>  #include <linux/kernel.h>
> @@ -21,6 +22,7 @@
>  #include <linux/unaligned.h>
>  #include "ufshcd-priv.h"
>
> +#define UFS_RPMB_ID_LEN                        16      /* Match eMMC CID=
 Length */
>  #define UFS_RPMB_SEC_PROTOCOL          0xEC    /* JEDEC UFS application =
*/
>  #define UFS_RPMB_SEC_PROTOCOL_ID       0x01    /* JEDEC UFS RPMB protoco=
l ID, CDB byte3 */
>
> @@ -154,6 +156,7 @@ int ufs_rpmb_probe(struct ufs_hba *hba)
>  {
>         struct ufs_rpmb_dev *ufs_rpmb, *it, *tmp;
>         struct rpmb_dev *rdev;
> +       char *dev_id =3D NULL;
>         char *cid =3D NULL;
>         int region;
>         u32 cap;
> @@ -213,8 +216,17 @@ int ufs_rpmb_probe(struct ufs_hba *hba)
>                         goto err_out;
>                 }
>
> -               descr.dev_id =3D cid;
> -               descr.dev_id_len =3D strlen(cid);
> +               dev_id =3D kzalloc(UFS_RPMB_ID_LEN, GFP_KERNEL);
> +               if (!dev_id) {
> +                       device_unregister(&ufs_rpmb->dev);
> +                       ret =3D -ENOMEM;
> +                       goto err_out;
> +               }
> +
> +               blake2s(NULL, 0, cid, strlen(cid), dev_id, UFS_RPMB_ID_LE=
N);
> +
> +               descr.dev_id =3D dev_id;
> +               descr.dev_id_len =3D UFS_RPMB_ID_LEN;

This change will break current users of this interface, if there are
any. There are currently no upstream users in OP-TEE since you're
adding that with https://github.com/OP-TEE/optee_os/pull/7881, but I
suppose that's not the only use case.

Cheers,
Jens


>                 descr.capacity =3D cap;
>
>                 /* Register RPMB device */
> @@ -228,6 +240,8 @@ int ufs_rpmb_probe(struct ufs_hba *hba)
>
>                 kfree(cid);
>                 cid =3D NULL;
> +               kfree(dev_id);
> +               dev_id =3D NULL;
>
>                 ufs_rpmb->rdev =3D rdev;
>                 ufs_rpmb->region_id =3D region;
> @@ -240,6 +254,7 @@ int ufs_rpmb_probe(struct ufs_hba *hba)
>         return 0;
>  err_out:
>         kfree(cid);
> +       kfree(dev_id);
>         list_for_each_entry_safe(it, tmp, &hba->rpmbs, node) {
>                 list_del(&it->node);
>                 device_unregister(&it->dev);
> --
> 2.54.0
>
