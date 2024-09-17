From: Jerome Forissier <jerome.forissier@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v1 1/1] tee: amdtee: Use %pUl printk() format specifier to
 print GUIDs
Date: Tue, 17 Sep 2024 09:22:19 +0200
Message-ID: <94e37138-ae66-4336-93ac-79683f2058aa@linaro.org>
In-Reply-To: <Zuf8fw1MM0jaisUh@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0810576896094091902=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0810576896094091902==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On 9/16/24 11:38, Andy Shevchenko wrote:
> On Mon, Sep 16, 2024 at 01:38:27PM +0530, Rijo Thomas wrote:
>> On 9/13/2024 2:59 PM, Andy Shevchenko wrote:
>>> On Thu, Sep 12, 2024 at 07:50:08AM +0200, Jens Wiklander wrote:
>>>> On Wed, Sep 11, 2024 at 10:41=E2=80=AFPM Andy Shevchenko
>>>> <andriy.shevchenko@linux.intel.com> wrote:
>>>>>
>>>>> Replace the custom approach with the %pUl printk() format specifier.
>>>>> No functional change intended.
>>>
>>>> Thanks, the patch looks like a nice simplificatrion.
>>>
>>> Thank you for the review.
>>>
>>>> Rijo, Devaraj, does this work for you?
>>>
>>> Yes, please test, because seems others use uuid_t (UUID BE) for TEE,
>>> but in this driver IIUC it's guid_t (UUID LE).
>>
>> No, this does not work for us. I tested this patch, it does not work as ex=
pected.
>>
>> %pUl gives output in uuid format (%08x-%04x-%04x-%02x%02x-%02x%02x%02x%02x=
%02x%02x).
>> But, what we need, is a name with the format %08x-%04x-%04x-%02x%02x%02x%0=
2x%02x%02x%02x%02x.
>>
>> Endian-ness is not an issue here. uuid generates name with 4 hypens (-).
>> While, in our TA naming we are using 3 hyphens (-).
>=20
> Ah, good catch! Can somebody add a comment there to explain that this uses
> non-standard human-readable representation of GUID/UUID?

Could this be due to some copying/pasting from the OP-TEE code base which had
a similar mistake prior to v2.3.0 [1][2][3]?

[1] https://github.com/OP-TEE/optee_os/blob/2.3.0/CHANGELOG.md?plain=3D1#L40-=
L45
[2] https://github.com/OP-TEE/optee_client/commit/a5b1ffcd26e3
[3] https://github.com/OP-TEE/optee_client/commit/365657667f89

>=20
> P.S. Thank you for testing!
>=20

Regards,
--=20
Jerome

--===============0810576896094091902==--

