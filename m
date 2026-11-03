Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC72606A338
	for <op-tee@archiver.kernel.org>; Tue,  3 Nov 2026 15:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VPcooBTx;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EbZz3636
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 4892A45463
	for <op-tee@archiver.kernel.org>; Tue,  3 Nov 2026 15:24:50 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VPcooBTx;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EbZz3636;
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 073F1452FB
	for <op-tee@lists.trustedfirmware.org>; Tue,  3 Nov 2026 15:24:30 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3E9xs72526854
	for <op-tee@lists.trustedfirmware.org>; Tue, 3 Nov 2026 15:24:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	b1Jf7yIZNINFepAMcdlza48j9DjWumf2wWjQ6qFxRvs=; b=VPcooBTxCDhHNlWu
	u50nJOPgFwIwrNCdvcd9ELscXuEk47b/QKFclC9AloHhAEYldaAmoaXWT6Kyqveh
	vGC9n12OmyTXa3djbLxV8++lQTAyIr38ZLJ1SG59H6B0BjNhrezHYTYPCB+FYmPC
	DZCtDSVaWvx6zJvS+6ZbytXg5JO49rgRV77sqJqU4Vlwt5oYWap9kpKzSHKmocjE
	dAAa8F8zcTRXwd9ERQfWQ27Wde3x087FFiqF+nyu8olZeaS8DXjGiRaVrvslehkD
	Kqsng8SHDgUHmYKQPDMlzWwaRtrnZbf66KStYYnLbxzXoo0mfbR5ulNwCq5JGKp+
	e5poUA==
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com [74.125.224.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq7yctph4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 03 Nov 2026 15:24:29 +0000 (GMT)
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-67a781c1069so6533731d50.1
        for <op-tee@lists.trustedfirmware.org>; Tue, 03 Nov 2026 07:24:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793719469; cv=none;
        d=google.com; s=arc-20260327;
        b=gTAl+ptnCSXGxcqV4z/y7Iz6Quni/HmsH53IMyDJDl+rU6mVHGIKupyFlP3oDpDnT8
         tdbJk4axTmiXpw+p9cab1YGIzAmxYyv8+5L7Gv6Dm+s6N1MrmQzz5QhYijwKb5K0C9SJ
         xESyPU2jUrcPFojufT3vbLf1tYhfkswkMiTAljoiduKXeK9t6qYlT1w6ueSVLfg7UNb/
         mniC3HUj58d/IGlFXEhetGzHxjRVcUhJiH52AIv4m4vJCcy3iNoMdcN/5q+FuwhG3BWF
         Kd9F1Dm405FIJFPeZCJ4ipHgMbnkuByQPyPRzddvaTTFsJVgFx7Q3DIhoGkxD5rAu7e3
         VHFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=b1Jf7yIZNINFepAMcdlza48j9DjWumf2wWjQ6qFxRvs=;
        fh=sqnm5jCWSN/PnQ34MKgOW6Gh6HVbMqeHLxZKBHi3gr8=;
        b=qoEoLe8+l8DqzioRE9us78SFjyxfVR5CrI4x26UOyFBCO9073jzac+JpB33lrFDO9K
         VrJ72yLP9QZWVk5Lkr6J1sYImfK6+7Pipp65h91/sElTc21ZOZuGgo0+6NbQl3tWWi40
         OWn9BNlbqszpm/EIqJe9nzLq9kVPh/4pb3Gvjnbpe1HBbCpBoJGkbiTWK6h5Fyd8Ktra
         b6iLkjT2juIi744URzf4p0rmGqIiAOmpWEC1SkN3+wy73E7BruRHgVcS/dMMhWHkwEQD
         h/u9vZDNGeyuspq86ZEBhKbwXtzrP83o3/aaKalMTndYNdHi/HHz33mK2cQXJEyt+dqb
         XV4g==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793719469; x=1794324269; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=b1Jf7yIZNINFepAMcdlza48j9DjWumf2wWjQ6qFxRvs=;
        b=EbZz3636VQVo8yVq8iUZjqwdAj/+vaoMXhpJG6wAMhQ+n8ZpQp/zcyB3qKIxYmacFU
         IgKMYF0u7CmJpkPgkpKpk1ClAcDn5MOE2yGqE3Ek68vyoqas2jfSqpyVsS2zmG563Lru
         oV5UwezVJszo4Y01jQ1n++JKwnDDaAz7PctbVjWfWnpqxVXwOGt9ITRPC0ywS8hPdNdw
         2ja9Y0/8yPKwYM6z8dCt8VTq/MFlLHp/2sno/tSnOFW2HZGO9loQqUPyswSKylLVjQoc
         I+01QWLiHTansEA5mXfjxU/2PgDgK5HEjt2HXVMjj4eAKcYtAJuuCaQcSPLZbP8MhLFB
         4DuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793719469; x=1794324269;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b1Jf7yIZNINFepAMcdlza48j9DjWumf2wWjQ6qFxRvs=;
        b=kNY+ReD7yP4BJRHn93QOddonHmmzLGPaHpZwlAUZRU36Q9I+8uXfzPK60tskB0X+Wt
         qQ3Tnx+CBXeVjBx70Eo9MjkxrLFnB0hXiIDBxMVIHMdwf9oOexXAN1NgUWfja3pHAcBt
         1Q/CJbPnlHwo/+mu44VtHJb2Q20THopmHYMNg8JysfIR1QJ7QLoH5BSh3SX4TZ6uFLou
         +K2bxaEKys8T5+V2aHsYtq5p4/LkzCmKcnWO6/xBg+wFsi7wtzbCY5X0MpbdpJ7AL470
         qT0da3rpCWFi3V+H0lP5jxW+JLt5sCSVMyiywERumUT7YF/NyJvrjyg6MRc0PREJOzfS
         hZmA==
X-Forwarded-Encrypted: i=1; AKwUvByu37bQGnBszXHBptkq2Sze6BHRe6udHInJI1URCzOp6yFtRnn1TYQJlubTpOp1WYGGtGqUJQA=@lists.trustedfirmware.org
X-Gm-Message-State: APuU4Z8w68k53SuGxuerI6DpbOcXeXwhq0oh/ko0Moh4poUtKUaLCk4C
	CINk18poOvhh6R/VUXQ1UPNf7MNdIaj4Af8HhnWeyvuZWHPBqBnIyLiAHrGOsl8gCsPrx4ki0wc
	aFtidSgXHUv3oBGXZqZtYAZtbzfYjr6CEg/SIK0sqXMB00kfTMa31lMFHcWpzYjLGn8Dmq6gpLL
	DKhNShwzYzeHAVODQdzGZBlK3VpNSTk43UqrQEnAzX74Mrn1E=
X-Gm-Gg: AYBFou2QDVFVFLPoQ/dhtjUR9SodqxFuOT7Ny4k4wlssvmWTcc3gRQ2sf1bhEB3EKS3
	qOwKlGmR3rZkaWyskJFRwY1auusY3hYv3IZP5PSJw7/0bQiIwNRu4jKHKleYFyw0AYPrqCKSjqQ
	X8T9zAKFoBmDGiv9lquuuoWvvn0On+ybCYVxX6PRPQp4bIZKDy1lg+8JWI61bNZKUWOOAXY0hEC
	jPaeuRZOIvsqsvdTy33TcZelra4SayEoQYKaBm6
X-Received: by 2002:a05:690e:138e:b0:67b:abb9:3d15 with SMTP id 956f58d0204a3-67babb948e3mr8554279d50.24.1793719468614;
        Tue, 03 Nov 2026 07:24:28 -0800 (PST)
X-Received: by 2002:a05:690e:138e:b0:67b:abb9:3d15 with SMTP id
 956f58d0204a3-67babb948e3mr8554263d50.24.1793719468109; Tue, 03 Nov 2026
 07:24:28 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261002145140.GA784348@rayden> <522a2d28-2ac9-4a56-8a61-477be3dfbbd9@app.fastmail.com>
 <CAGgiveUDQvqpJKo4XuboP_46t7DPSBT1jdaTafROvobk2V5mwQ@mail.gmail.com>
In-Reply-To: <CAGgiveUDQvqpJKo4XuboP_46t7DPSBT1jdaTafROvobk2V5mwQ@mail.gmail.com>
From: Jens Wiklander <jens.wiklander@oss.qualcomm.com>
Date: Tue, 3 Nov 2026 16:24:17 +0100
X-Gm-Features: AclHuK_7QkcnsqO7rpddbyxmd5bsrxtK9QzYCDAUOQsSq6QU6rohTZ3Vg-dyLMA
Message-ID: <CAGgiveWadMfHBMu=vSeqwgoz8rcXXg4E9OrAKnkWPPFn07pimw@mail.gmail.com>
Subject: Re: [GIT PULL] OP-TEE update for v7.4
To: Marouene Boubakri <marouene.boubakri@oss.nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=V7foQuni c=1 sm=1 tr=0 ts=6ae9fcad cx=c_pps
 a=S/uc88zpIJVNbziUnJ6G4Q==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8 a=h2ZEknDc1N0j5eo6QzAA:9
 a=QEXdDO2ut3YA:10 a=nd2WpGr1bMy9NW-iytEl:22
X-Proofpoint-ORIG-GUID: tMUKqN6VHxZyuCwvsitAO78gjI1qDPK5
X-Proofpoint-GUID: tMUKqN6VHxZyuCwvsitAO78gjI1qDPK5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA2MSBTYWx0ZWRfX0uVuHiLUED3n
 feglgQhpauFnDPyiW5HAqxqL/IO8tWI6J6eG0RzvjeKiM/NiEhBkc0izHqICNJdzb8nb6yVAomC
 LltBpmZYib2e1OrMu2l3iGtrdISFqaUuvP9f6+4ewvzTn8n8CwY4iUmaAtz4IJq3fBFXGn9LxEq
 QglV9sTYJPS8W2MBW30Uo+xftx8ezFxfq+OjXZa176BQufPxRA9muChq5I/28y7rz6vkN9U842m
 9+U4yBaGQgDIjfGKhg6qUf1nuocZWPH7Mhzv6g0rBRTgBZCBl6YmVs/YvwDWOkf/8X+3TvJXuVs
 w2lTm5vMd14kczlcrEaZ/8JbG+N38zdKZshLo9LG741JDkE/+gLlXFUmP8BYWhWJqULx+CTlnny
 PYqONGUU2JHYY/z3BBW2CuvOb8nRhRAloUJMROlGKY9SCn1vzwn/L7IZmNjWMrVR0+/PyX6EUW4
 wfKAFX7aZqyIjGgIpaQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA2MSBTYWx0ZWRfX2Zv78oyn0MrC
 Ctlpy2s5+0SRWkrWns1Oz1vluHXkleicuQkJrEfNkFX74qXIMM70ImdRs0xjye3pPzu31X0hB+M
 8eib/rjx2F0WEFk7HgaQBHNlC3lERGs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_03,2026-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 clxscore=1015 bulkscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030061
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	ARC_ALLOW(-1.00)[google.com:s=arc-20260327:i=1];
	DMARC_POLICY_ALLOW(-0.50)[oss.qualcomm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_NONE(0.00)[74.125.224.70:received];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 073F1452FB
X-Spamd-Bar: -------
Message-ID-Hash: YRKTJ5HQUAKCHZAZREGMCOQVQCLGULVM
X-Message-ID-Hash: YRKTJ5HQUAKCHZAZREGMCOQVQCLGULVM
X-MailFrom: jens.wiklander@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: arm <arm@kernel.org>, soc@kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, Arnd Bergmann <arnd@arndb.de>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/YRKTJ5HQUAKCHZAZREGMCOQVQCLGULVM/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Marouene,

Can you make a v5 of "[PATCH v4] tee: optee: build the Arm-specific
code only on Arm" addressing Arnd's comments, please? That is,
replacing IS_REACHABLE() with IS_ENABLED() in the patch. As Arnd
points out, with  OPTEE depending on ARM_FFA_TRANSPORT ||
!ARM_FFA_TRANSPORT, the code is always reachable if enabled.

Thanks,
Jens

On Wed, Oct 14, 2026 at 8:34=E2=80=AFAM Jens Wiklander
<jens.wiklander@oss.qualcomm.com> wrote:
>
> Hi Arnd,
>
> On Tue, Oct 13, 2026 at 4:53=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wro=
te:
> >
> > On Fri, Oct 2, 2026, at 16:51, Jens Wiklander wrote:
> > > for you to fetch changes up to ccd4b23398acaf2139cf04f1ba0a66150cbf26=
63:
> > >
> > >   tee: optee: build the Arm-specific code only on Arm (2026-10-02
> > > 16:28:41 +0200)
> > >
> > > ----------------------------------------------------------------
> > > Build the OP-TEE driver's SMC and FF-A code only where supported
> > >
> > > ----------------------------------------------------------------
> > > Marouene Boubakri (1):
> > >       tee: optee: build the Arm-specific code only on Arm
> >
> > I had a look at the contents and saw that it keeps the
> > IS_REACHABLE() checks that are notoriously error-prone.
> > E.g. this part just looks broken:
> >
> > @@ -257,8 +266,12 @@ struct optee {
> >         const struct optee_ops *ops;
> >         struct tee_context *ctx;
> >         union {
> > +#ifdef CONFIG_HAVE_ARM_SMCCC
> >                 struct optee_smc smc;
> > +#endif
> > +#if IS_REACHABLE(CONFIG_ARM_FFA_TRANSPORT)
> >                 struct optee_ffa ffa;
> > +#endif
> >         };
> >         struct optee_shm_arg_cache shm_arg_cache;
> >         struct optee_call_queue call_queue;
> >
> > The presence of the 'ffa' member in the union is conditional
> > on whether the driver that includes the header is a loadable
> > module or built-in, and this changes the entire structure
> > layout if both types of users are present.
> >
> > The intention of the patch does make a lot of sense,
> > but as far as I can tell, only the Kconfig change is
> > actually required, while the added preprocessor checks
> > only make it harder to read and it should have been
> > sufficient to change the existing IS_REACHABLE() to
> > IS_ENABLED() for consistency.
> >
> > Sorry I did not notice this one earlier as I was travelling,
> > but I think I can't pull this version, please respin.
>
> Thanks for catching this. We'll repin.
>
> Cheers,
> Jens
