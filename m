From: Jerome Forissier <jerome.forissier@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: PKCS11 TA: MR https://github.com/OP-TEE/optee_os/pull/5166
Date: Mon, 19 Jun 2023 16:31:43 +0200
Message-ID: <05a58cb1-52a7-5fdc-f350-047a871fc47b@linaro.org>
In-Reply-To: <
 <CAHUa44HM-JVR0cdKA1gmT+5D9OKNh34-FWkQcnOGYWrC_SRQ2Q@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0579198507666274927=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0579198507666274927==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit



On 6/19/23 16:08, Jens Wiklander wrote:
> Hi Cedric,
> 
> On Mon, Jun 19, 2023 at 3:50 PM dourlent cédric
> <cedric.dourlent@gmail.com> wrote:
>>
>> Hi,
>>
>> I contact you about the merge request
>> https://github.com/OP-TEE/optee_os/pull/5166 that is mandatory to be able
>> to use ECC private key imported in PKCS11 TA and not generate by the TA.
>>
>> Currently the status is
>> Attribute on generated ECC private key are
>> - EC_PARAMS
>> - VALUE
>> - EC_POINT
>> => This object can be use for crypto operation
>>
>> Attribute on imported ECC private key are
>> - EC_PARAMS
>> - VALUE
>> => PKCS11 TA can not use it because TA expect EC_POINTS attributes on ECC
>> Private key.
>>
>> Could you accept the merge request and have a coherence between generated
>> and imported object even if for the moment it's doesn't respect PKCS11
>> standard ?
>>
>> Two options for the next step.
>> - check with PKCS11 editors to upgrade the spec and have a same behavior
>> between RSA Private object and ECC Private object.
>> - rework the code of the TA for ECC to link Private and public object but
>> that mean that ECC Private and Public object must be present in the same
>> slot to be able to perform crypto operation.
> 
> I think it's easier to keep this discussion in the pull request you
> mentioned above, or there's a risk that others might miss that it has
> moved elsewhere.

I have re-opened the PR, in case it was the reason for not continuing there
(admins can add comments to closed PRs, but I suppose non-admins cannot).

Thanks,
-- 
Jerome

>
> Thanks,
> Jens
> 
>>
>> Best regards,
>>
>> Cédric Dourlent,

--===============0579198507666274927==--

