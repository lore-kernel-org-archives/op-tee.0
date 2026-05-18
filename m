Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D635ACD4F3C
	for <op-tee@archiver.kernel.org>; Mon, 18 May 2026 06:36:35 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 0CB6E44DEB
	for <op-tee@archiver.kernel.org>; Mon, 18 May 2026 06:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1779086195;
	bh=5RFO+Ssvg4JmPw/yA4u/nPzTGuYXVhi4EeKK7/9cMjw=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=tgbZGRj9arpjoe4eGb2wbzOZpFgBDlv438CfR3JcXuHry3m+1WHZmixWGsDBg2wN9
	 SVNSJmEmdJ4TImINGpiKbVqiUcBE/GRazqDkDg4nBnmh6T5G6hujix0J+jXBxdsZxp
	 gtJohy2oidVC35Bz77uDTlFoJpdGovChiWnk3w6Djdi/hz0azeK2YbMlOo+uD+hddi
	 ePyJ3Fpn3X14es+VH7GhorIbMulwyb4Hl3YvRmXVm2WyVBd+6UvQQVYWdg1YvX0Y01
	 mQMlQ61CILtM6Oe3QEEqkDEEfaxZcCj0cxh5s04IdAtKOxhWC/veHH9Dxu8WdHWfpV
	 yQzZRo4dTRQHg==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id D37B64423C
	for <op-tee@lists.trustedfirmware.org>; Mon, 18 May 2026 06:36:28 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=m/QupLAN;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kqxm7945;
	dkim-atps=neutral
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64HLDAoJ378018
	for <op-tee@lists.trustedfirmware.org>; Mon, 18 May 2026 06:36:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OhWjBMRcsj+kQRn2s4H2mf5lmW3+OFeXfq83HZ0y7aE=; b=m/QupLAN2LODnD+C
	1P+6W3OdBFoGdhgeeDxf4ZtQ/rsutO1IA9kh5gKqeZ6nEZJH5eqe+RNl0HRrdeJ/
	V8bPW352grJGS9o/uz4btRY9KY6O+/w1bLUTVALAIyo8g3XwHY+FOfZzTlF9bj5X
	hKWA2uWixvvB1NEue6ZAdsa1LdINFuOS7RtGdwsdZ9U34ppEwyTjpPyIEdJvQ7ef
	ZS5U+RjDTKfrFimo+Mki1a3zlnSTCYcGCFJh6Uf3lOR2Z7POlYFkbSckkZTt4Ltf
	8zFrQkYUSmy+t6o/9e587Yl/NjYdS+gq79PlN+meOlpQjSw5H9YpjkF97fr6AbyK
	CHyL/A==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e6gx6vye9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Mon, 18 May 2026 06:36:27 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-368b68a33adso3005820a91.1
        for <op-tee@lists.trustedfirmware.org>; Sun, 17 May 2026 23:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779086187; x=1779690987; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OhWjBMRcsj+kQRn2s4H2mf5lmW3+OFeXfq83HZ0y7aE=;
        b=kqxm7945C1IobC7TCdny1iZFMrurjAWNc4RtYAoid88GwkSyYxh0mfHeVV2tK2vMt7
         nrJCa+HDiQP3gBJLQgRy0H2t1zCpUiPilh6ffDM0AwElvqhCJU3lhoBASbNQNMtcejTO
         9bqtpaSxD5mMHzSFF28tHHRHi99H4yNQK0BP4cWqdUBuuTBeCIP5Rl4PkUbiDGwc7GEc
         Lh7riWbDutFVOn9v88C2Ku1IIizQSV4gw/tshsRQaDGRfKmqV8T2DX2pnbNWyn5S+7gZ
         gczLukhvDNf7RcOZLnEo/gfWgJYT+i58OI4H+ru1ac8bPQnpWzZ2hoVdPwEHxR1LL1Z2
         QZzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779086187; x=1779690987;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OhWjBMRcsj+kQRn2s4H2mf5lmW3+OFeXfq83HZ0y7aE=;
        b=hLiRwNVi1Y8u+TQkDn1yTKZmgODBU7cFz9PjRYETbZ9QUgOE8fsuLD5N9tDodJ4CZN
         3KBpBvtf3H1chz5WNNLZeGpQgtjUfV43GZ4W5bj+SGY/4EDniHt/mPmtgqEncD6MHt1x
         Hwt/wx3g9ZJsa3ZsZQEzZrfZwY2eZzCk/WbWB7ZnI0KK7awvsIswwMqC2VbBuhhpxeS3
         kfgYo69kGkxXM4YFcbOZ8fVasLskqgI2kn2mLIv4bA6ZgDL7LN/4UJ1mj3svOw+acJ3V
         vA3rJvqhmlDq5B3/VvOVpNTk80iwnU+gC71dbm9EIdr7JNM1/CCjHOP7mztkAY+ui99a
         +Q8Q==
X-Forwarded-Encrypted: i=1; AFNElJ9M/9EBBy1EYDrrPR5dw9HnBTYldZRH8nzWMIbpt6w02vqA82mMu3lgSGla5eL+DITYp7S9s4c=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxxBHj7qT1V8cCokafOYgyPe6yDKd66JOiUdHRiMWzqWIJKJ74T
	cv01J/ydJxSpWDjzcv/JLR6zE5XGXSKG5ktgyEc5jIIZI8+tlOTzwcGo05ttsVYzSpgRqXIG+cg
	h4A/wpqlLZewqMZ5mKLqFOTSFHPLSXoaZqDvbCNsbcBa1Ixim3b6DzXFJXSl0Slj85gdOWNo=
X-Gm-Gg: Acq92OEtCmlT3ExP5he5wXRWkBHYdlyKJFsJXQy7MjX4bd8xbOdZxggw+yBvpYt7Hqi
	jnUgMAdDpnKw0oGak9dG0pCVGrSgBGHtua+xbAjhNchi0b5h7u6fl45sT/QL3mnylxe8S5LtG3y
	8cjohuVGPvo1THwmmAMbwBqd+9TrofcAHw2lqum/kVErethO2OdSkicfJ32psI9MVjs6L08oHrO
	FNU7U20PhXwGzn0ahvjRpr3p6stoTLFbUCG4T8dWfzVgoM2lETz6HO3CB4HPZxJRYUL35MAK9nh
	15MaXRj8GqIVnxKwbpnXBn3gGv4bKD2r3gm/lcd+Uo3KuOoeS/3F2tjLUxjGyR0YvnBAG8fSjm0
	2aMvoNmzuvvHSWizAgsYZ5H/BOeDEs0TNuF8IL1CF6R8wQpaSATFwjs0Hx3UfrIH5EhPBXmW44J
	Tzb5e4usZJYa4Pn1hL6Eg=
X-Received: by 2002:a17:90b:4c51:b0:368:2074:b7a with SMTP id 98e67ed59e1d1-369519af671mr13714077a91.5.1779086186761;
        Sun, 17 May 2026 23:36:26 -0700 (PDT)
X-Received: by 2002:a17:90b:4c51:b0:368:2074:b7a with SMTP id 98e67ed59e1d1-369519af671mr13714036a91.5.1779086186266;
        Sun, 17 May 2026 23:36:26 -0700 (PDT)
Received: from [192.168.0.74] (n1-41-240-65.bla22.nsw.optusnet.com.au. [1.41.240.65])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36951278e7fsm9708269a91.8.2026.05.17.23.36.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 May 2026 23:36:25 -0700 (PDT)
Message-ID: <e626963b-7f20-43fd-b3e0-e16d9b6f13f8@oss.qualcomm.com>
Date: Mon, 18 May 2026 16:36:20 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tee: qcomtee: add missing va_end in early return
 qcomtee_object_user_init()
To: Robertus Diawan Chris <robertusdchris@gmail.com>
References: <20260513091031.145826-1-robertusdchris@gmail.com>
 <8182784b-b6c2-4136-af8d-3aea4f5a4662@oss.qualcomm.com>
 <agat1sBHqkGWKzOD@soyboi>
Content-Language: en-US
In-Reply-To: <agat1sBHqkGWKzOD@soyboi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: WWhEo-WF6-zh3AxiFcXFiySC5Zvkd2Op
X-Authority-Analysis: v=2.4 cv=f614wuyM c=1 sm=1 tr=0 ts=6a0ab36b cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=hi51d+lTLNy/RbqRqnOomQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=pGLkceISAAAA:8 a=X36vB_roDklc4VALgUkA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: WWhEo-WF6-zh3AxiFcXFiySC5Zvkd2Op
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDA2MSBTYWx0ZWRfX8vb39PN5m1Zy
 pR7rblBKLom7GiN9FkSGJt5jJmFHbHK0MAxdU4JE58q6veiNbrFRpdEif44BjxEe+HpZ6q3a3pf
 wFg+4aa828Lsvuj1gZJVl8/nEcWTosnS5ituliF30CNHv0uHt4t6uQqSOzkQ/OduAqp00aTcxby
 Gj/LbD7B9Aks11Kh44DyyQtR6DYOlevu9DWgB7IsaeZ4zt+dwx+a4THufMGQ0epnx/sVTggtQl+
 2EFQGXaU9QLYa6A+GcJlLyBaMyl707qgrFpY7dRAVRFtNMTcq0HJsPrCzrizZap6YA4JcqZ/Kb4
 AHU5Mxw+0+svZt5MgrqLlhtgWrtH41x5Y/oi/qgHLmaNpCAdB+A1u6GwVvaxzGlnI9W4vnbDQqg
 FJpi52KJaXOff0iQuoZMYgA5LPiqSZY+5CZabHq49ZlPFmUoKfltTgbQ+Q39pd8wJ1mmw3HUac1
 iGmLBSP6szULufqxH6g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_01,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 spamscore=0 suspectscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180061
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.216.71:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: D37B64423C
X-Spamd-Bar: ------
Message-ID-Hash: WLXOYZMN2EHHCQOFKORFUL5C6FQ3XLTM
X-Message-ID-Hash: WLXOYZMN2EHHCQOFKORFUL5C6FQ3XLTM
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: sumit.garg@kernel.org, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org, skhan@linuxfoundation.org, me@brighamcampbell.com
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/WLXOYZMN2EHHCQOFKORFUL5C6FQ3XLTM/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

Hi,

On 5/15/2026 3:23 PM, Robertus Diawan Chris wrote:
> Hello Amir,
> 
> On Fri, May 15, 2026 at 11:31:50AM +1000, Amirreza Zarrabi wrote:
>> On 5/13/2026 7:10 PM, Robertus Diawan Chris wrote:
>>> qcomtee_object_user_init() is a variadic function and when the function
>>> return because there's no dispatch callback in QCOMTEE_OBJECT_TYPE_CB
>>> case, there's no va_end to cleanup "ap" object initialized by va_start
>>> and that can cause undefined behavior. So make sure to use va_end before
>>> returning the error code when there's no dispatch callback.
>>>
>>> This is reported by Coverity Scan as "Missing varargs init or cleanup".
>>>
>>> Fixes: d6e290837e50 ("tee: add Qualcomm TEE driver")
>>> Signed-off-by: Robertus Diawan Chris <robertusdchris@gmail.com>
>>> ---
>>> I don't have the device, so I am not sure how to test this change.
>>> Thank you.
>>>
>>>  drivers/tee/qcomtee/core.c | 8 ++++++--
>>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/tee/qcomtee/core.c b/drivers/tee/qcomtee/core.c
>>> index b1cb50e434f0..901a31e8201f 100644
>>> --- a/drivers/tee/qcomtee/core.c
>>> +++ b/drivers/tee/qcomtee/core.c
>>> @@ -306,8 +306,10 @@ int qcomtee_object_user_init(struct qcomtee_object *object,
>>>  		break;
>>>  	case QCOMTEE_OBJECT_TYPE_CB:
>>>  		object->ops = ops;
>>> -		if (!object->ops->dispatch)
>>> -			return -EINVAL;
>>> +		if (!object->ops->dispatch) {
>>> +			ret = -EINVAL;
>>> +			goto out;
>>> +		}
>>>
>>>  		/* If failed, "no-name". */
>>>  		object->name = kvasprintf_const(GFP_KERNEL, fmt, ap);
>>> @@ -320,6 +322,8 @@ int qcomtee_object_user_init(struct qcomtee_object *object,
>>>  	default:
>>>  		ret = -EINVAL;
>>>  	}
>>> +
>>> +out:
>>>  	va_end(ap);
>>>
>>>  	return ret;
>>>
>>> base-commit: 5d6919055dec134de3c40167a490f33c74c12581
>>
>> Hi,
>>
>> Forgot to mention: how about using a break instead of a goto.
> 
> Oh right. In this case, using "break" statement is enough. I will send
> the v2 of the patch. Maybe something like this:
> 
> 	if (!object->ops->dispatch) {
> 		ret = -EINVAL;
> 		break;
> 	}
> 
> and then remove the "out" label.
> 
>> Then feel free to add Reviewed-by.
> 
> I want to confirm first, if I changed the patch using "break" statement,
> do I need to add "Reviewed-by" tag in the v2 of the patch or not? I am
> still not sure when to add "Reviewed-by" tag, like can we add
> "Reviewed-by" tag when we changed the patch?
> 

This is a small change. You can add the tag when sending your v2
as long as you include the change.

Best Regards,
Amir

> Thank you.
> 
> Best regards,
> Robertus Diawan Chris

