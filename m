From: Florian Fainelli <f.fainelli@gmail.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v5 8/8] firmware: tee_bnxt: Release TEE shm, session, and
 context during kexec
Date: Tue, 20 Jul 2021 11:59:00 -0700
Message-ID: <22e55ae6-3ecb-4f54-b9e6-1b902d4d4e20@gmail.com>
In-Reply-To: <20210720181517.GF3232@sequoia>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4101876073489428289=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4101876073489428289==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 7/20/21 11:15 AM, Tyler Hicks wrote:
> On 2021-07-20 10:57:18, Florian Fainelli wrote:
>>
>>
>> On 7/19/2021 7:32 PM, Florian Fainelli wrote:
>>>
>>>
>>> On 7/19/2021 3:49 AM, Jens Wiklander wrote:
>>>> Hi,
>>>>
>>>> On Fri, Jul 16, 2021 at 4:48 AM Vikas Gupta
>>>> <vikas.gupta@broadcom.com> wrote:
>>>>>
>>>>> Hi Allen/Tyler,
>>>>> =C2=A0 The patch looks good to me.
>>>>
>>>> Thanks.
>>>>
>>>> Rafal, is it OK if I include this patch together with the rest of the
>>>> patches in this patch set in a pull request to arm-soc?
>>>
>>> I can take those patches through the Broadcom ARM SoC pull request,
>>> Rafal would that work for you? We seem to have a bit of a maintainer
>>> coverage blind spot for that directory.
>>
>> Applied to drivers/fixes: https://github.com/Broadcom/stblinux/commit/4ecd=
797b7e16eb7f1b86fbfd7e4a7887b192535b
>=20
> Thanks, Florian, but note that you won't be able to build that branch
> since the commit uses a new function (tee_shm_alloc_kernel_buf()) that's
> added earlier in the full series. It seems like it is going to be easier
> for this to all go through Jens.

I was grepping for the new functions added and could find all
references, though it looks like I missed tee_shm_alloc_kernel_buf()
somehow, so yes, having Jens merge that series all together would make
more sense here. If you need it:

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
--=20
Florian

--===============4101876073489428289==--

