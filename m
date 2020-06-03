From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [op-tee] [PATCH v5 0/4] Introduce TEE based Trusted Keys support
Date: Wed, 03 Jun 2020 13:37:44 +0530
Message-ID: 
 <CAFA6WYOoMdLJ2g3gocZBZWdu-7Nfw7LKHnzX8S8FKeC7cuNwYg@mail.gmail.com>
In-Reply-To: <1591108981.4253.17.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2776115714273294831=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2776115714273294831==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Tue, 2 Jun 2020 at 20:14, James Bottomley <jejb@linux.ibm.com> wrote:
>
> On Tue, 2020-06-02 at 19:48 +0530, Sumit Garg wrote:
> > Add support for TEE based trusted keys where TEE provides the
> > functionality to seal and unseal trusted keys using hardware unique
> > key. Also, this is an alternative in case platform doesn't possess a
> > TPM device.
>
> So here's a meta problem: in the case when the platform possesses both
> TEE and TPM  what should it do?

IMO, trust source (either a TPM or a TEE) should be unique and
carefully chosen as per platform security policy corresponding to a
particular threat model.

And moreover TEEs have been mostly used in the embedded world where
having a hardware TPM is cumbersome given constraints regarding BoM
cost and hardware resources.

>  Things like this:
>
> > --- a/security/keys/trusted-keys/trusted_core.c
> > +++ b/security/keys/trusted-keys/trusted_core.c
> > @@ -25,6 +25,8 @@
> >
> >  #if defined(CONFIG_TRUSTED_TPM)
> >  static struct trusted_key_ops *trusted_key_ops =
> > &tpm_trusted_key_ops;
> > +#elif defined(CONFIG_TRUSTED_TEE)
> > +static struct trusted_key_ops *trusted_key_ops =
> > &tee_trusted_key_ops;
> >  #else
>
> Say it's either/or at a Kconfig level: so if you select both TEE and
> TPM based trusted keys at compile time, we intall the TPM ops and
> ignore the TEE ops, is that right?  Surely this should be runtime
> selectable based on what the platform has ...

This dynamic selection was already part of v4 patch-set but after
objection from Jarrko here [1], I switched to compile time mode
instead.

[1] https://lkml.org/lkml/2020/6/2/139

> perhaps it should even be
> selectable per key?
>
> Once it is runtime selectable, what should be selected in the both
> case?  Or should we allow the user to decide, if so, how?
>
> when you pipe a trusted key, I think the subtype (TEE or TPM) should be
> part of the piped information, so it loads again seamlessly.  This
> would actually be fixed by something like the ASN.1 scheme I'm trying
> to upstream, at least for TPM keys, but do TEE keys have a recognized
> ASN.1 format?
>

I guess this is something which we can refine later if there are real
platforms that have a particular security requirement to support both
TPM and a TEE.

-Sumit

> James
>

--===============2776115714273294831==--

