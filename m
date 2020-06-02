From: James Bottomley <jejb@linux.ibm.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [op-tee] [PATCH v5 0/4] Introduce TEE based Trusted Keys support
Date: Tue, 02 Jun 2020 07:43:01 -0700
Message-ID: <1591108981.4253.17.camel@linux.ibm.com>
In-Reply-To: <1591107505-6030-1-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6347501082429351545=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6347501082429351545==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Tue, 2020-06-02 at 19:48 +0530, Sumit Garg wrote:
> Add support for TEE based trusted keys where TEE provides the
> functionality to seal and unseal trusted keys using hardware unique
> key. Also, this is an alternative in case platform doesn't possess a
> TPM device.

So here's a meta problem: in the case when the platform possesses both
TEE and TPM  what should it do?  Things like this:

> --- a/security/keys/trusted-keys/trusted_core.c
> +++ b/security/keys/trusted-keys/trusted_core.c
> @@ -25,6 +25,8 @@
>  
>  #if defined(CONFIG_TRUSTED_TPM)
>  static struct trusted_key_ops *trusted_key_ops =
> &tpm_trusted_key_ops;
> +#elif defined(CONFIG_TRUSTED_TEE)
> +static struct trusted_key_ops *trusted_key_ops =
> &tee_trusted_key_ops;
>  #else

Say it's either/or at a Kconfig level: so if you select both TEE and
TPM based trusted keys at compile time, we intall the TPM ops and
ignore the TEE ops, is that right?  Surely this should be runtime
selectable based on what the platform has ... perhaps it should even be
selectable per key?

Once it is runtime selectable, what should be selected in the both
case?  Or should we allow the user to decide, if so, how?

when you pipe a trusted key, I think the subtype (TEE or TPM) should be
part of the piped information, so it loads again seamlessly.  This
would actually be fixed by something like the ASN.1 scheme I'm trying
to upstream, at least for TPM keys, but do TEE keys have a recognized
ASN.1 format?

James


--===============6347501082429351545==--

