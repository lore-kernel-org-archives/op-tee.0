From: Florian Fainelli <f.fainelli@gmail.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v5 8/8] firmware: tee_bnxt: Release TEE shm, session, and
 context during kexec
Date: Tue, 20 Jul 2021 10:57:18 -0700
Message-ID: <bc3f4bdd-b833-d58c-f7d7-6670bcbd8ef8@gmail.com>
In-Reply-To: <903824a6-7a2b-1514-5b71-a2db634e9abf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2996286262200312962=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2996286262200312962==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On 7/19/2021 7:32 PM, Florian Fainelli wrote:
>=20
>=20
> On 7/19/2021 3:49 AM, Jens Wiklander wrote:
>> Hi,
>>
>> On Fri, Jul 16, 2021 at 4:48 AM Vikas Gupta <vikas.gupta@broadcom.com>=20
>> wrote:
>>>
>>> Hi Allen/Tyler,
>>> =C2=A0 The patch looks good to me.
>>
>> Thanks.
>>
>> Rafal, is it OK if I include this patch together with the rest of the
>> patches in this patch set in a pull request to arm-soc?
>=20
> I can take those patches through the Broadcom ARM SoC pull request,=20
> Rafal would that work for you? We seem to have a bit of a maintainer=20
> coverage blind spot for that directory.

Applied to drivers/fixes:=20
https://github.com/Broadcom/stblinux/commit/4ecd797b7e16eb7f1b86fbfd7e4a7887b=
192535b
--=20
Florian

--===============2996286262200312962==--

