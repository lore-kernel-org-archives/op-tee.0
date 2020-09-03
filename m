From: Achin Gupta <Achin.Gupta@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: Linaro OP-TEE Contributions meeting Aug 2020
Date: Thu, 03 Sep 2020 11:37:47 +0000
Message-ID: <D3D19F82-76AC-4245-A15C-AAEBBF11CBCC@arm.com>
In-Reply-To: <=?utf-8?q?=3CDB6PR0402MB27604D0C2C6136271CACD5D0882C0=40DB6PR04?=
 =?utf-8?q?02MB2760=2Eeurprd04=2Eprod=2Eoutlook=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0534670479818507889=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0534670479818507889==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Peng,

> On 3 Sep 2020, at 11:14, Peng Fan <peng.fan@nxp.com> wrote:
>=20
>> Subject: Re: Linaro OP-TEE Contributions meeting Aug 2020
>>=20
>> Hi Peng,
>>=20
>>=20
>>> On 3 Sep 2020, at 10:34, Jens Wiklander via OP-TEE
>> <op-tee@lists.trustedfirmware.org> wrote:
>>>=20
>>> Hi Peng,
>>>=20
>>> On Fri, Aug 28, 2020 at 9:10 AM Peng Fan via OP-TEE
>>> <op-tee@lists.trustedfirmware.org> wrote:
>>>>=20
>>>> I was not able to join the meeting. Just wonder for S-EL2, is there any
>> platform supporting it? How to test?
>>=20
>> Just to be sure, you mean support for running OP-TEE under a Hypervisor/SPM
>> in S-EL2?
>=20
> Yes. Actually I not follow the design decision that supporting multiple TEE=
s in secure
> world. But anyway current OP-TEE support multiple XEN VMs contributed by EP=
AM,
> could this not serve normal world VM per future requirement?

A couple of things assuming I am understanding your question/concern correctl=
y.

S-EL2 enables deployment of multiple TEEs. However, this is not the only use =
case. More importantly, it allows the TEE to access only the physical address=
 space it needs to. This helps in mitigating attacks on the Normal world from=
 the TEE. Furthermore, it enables isolation/separation of a TEE from privileg=
ed firmware in EL3 and S-EL2. This helps in compartmentalising the TCB if not=
 reduce its size altogether. So there is the =E2=80=9Cdefense in depth/princi=
ple of least privilege=E2=80=9D argument too.

This is the first step in the S-EL2 enablement story for OP-TEE i.e. run OP-T=
EE as a Secure VM under TF-A in EL3 and SPM in S-EL2. We have done some work =
on the FVP within Arm to enable this and will share it with Jens and publicly=
 soon.

Multiple-TEEs is a deployment choice. For example, Vendor A has TEE1 on which=
 its Trusted Apps run. Vendor B has TEE2 which implements drivers to Secure p=
eripherals that TAs of TEE1 need. It might not be practical or feasible for V=
endor A to port its TAs to TEE2. Hence, the two TEEs need to co-exist and com=
municate. S-EL2 enables isolation between TEE1 and TEE2. This helps reduce th=
e level of trust that TEE2 should have on TEE1 and vice-versa.

EPAM=E2=80=99s contribution adds awareness of virtualisation in the Normal wo=
rld to OP-TEE. This enables OP-TEE to isolate communication channels, data et=
c associated with one VM from another. Without this isolation, there is a ris=
k of information of one VM leaking into another. Jens should have more detail=
 on this topic.

I hope this helps to clarify your concerns. Please let me know.

Cheers,
Achin

=20
>=20
> Thanks,
> Peng.
>=20
>=20
>>=20
>> Cheers,
>> Achin
>>=20
>>>=20
>>> This is tested and developed using FVP as far as I know.
>>>=20
>>> Cheers,
>>> Jens
>>>=20
>>>>=20
>>>> Thanks,
>>>> Peng.
>>>>=20
>>>> From: Joakim Bech [mailto:joakim.bech(a)linaro.org]
>>>> Sent: 2020=E5=B9=B48=E6=9C=8827=E6=97=A5 16:21
>>>> To: op-tee(a)lists.trustedfirmware.org
>>>> Subject: Re: Linaro OP-TEE Contributions meeting Aug 2020
>>>>=20
>>>> Hi,
>>>>=20
>>>> Just a friendly reminder, that we have the first public "Linaro OP-TEE
>> Contributions" meeting taking place later today.
>>>> 2020-08-27(a)16.00<mailto:2020-08-27@16.00> UTC+2, 1h duration (for
>> other timezones, use this URL
>> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Feveryti
>> mezone.com%2Fs%2F12a83ab5&amp;data=3D02%7C01%7Cpeng.fan%40nxp.co
>> m%7C66d0df88519741b75aff08d84fef6af3%7C686ea1d3bc2b4c6fa92cd99c5
>> c301635%7C0%7C0%7C637347236997122381&amp;sdata=3D3T5L%2F0kMhB
>> GT%2BTu1FWxClGihm1mcKIhe52xYJeCUc68%3D&amp;reserved=3D0<https://e
>> ur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Feverytimezone.
>> com%2Fs%2F12a83ab5&amp;data=3D02%7C01%7Cpeng.fan%40nxp.com%7C6
>> 6d0df88519741b75aff08d84fef6af3%7C686ea1d3bc2b4c6fa92cd99c5c30163
>> 5%7C0%7C0%7C637347236997122381&amp;sdata=3D3T5L%2F0kMhBGT%2BT
>> u1FWxClGihm1mcKIhe52xYJeCUc68%3D&amp;reserved=3D0>). Connection
>> details and etc can be found in the email below.
>>>>=20
>>>> This time I've also included more people on BCC who might not have
>> subscribed to the
>> <op-tee(a)lists.trustedfirmware.org<mailto:op-tee@lists.trustedfirmware.=
org
>>>> list.
>>>>=20
>>>> Regards,
>>>> Joakim
>>>>=20
>>>> On Wed, 19 Aug 2020 at 15:52, Joakim Bech via OP-TEE
>> <op-tee(a)lists.trustedfirmware.org<mailto:op-tee@lists.trustedfirmware.=
org
>>>> wrote:
>>>> Hi,
>>>>=20
>>>> As part of opening up Linaro projects to the general public we plan
>>>> to have an open monthly meeting where we discuss Linaro's activities
>> around OP-TEE.
>>>> The way that we've planned to do this is that we send out an email to
>>>> this email list
>>>>=20
>> (https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists=
.tr
>> ustedfirmware.org%2Fmailman%2Flistinfo%2Fop-tee&amp;data=3D02%7C01%
>> 7Cpeng.fan%40nxp.com%7C66d0df88519741b75aff08d84fef6af3%7C686ea1
>> d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637347236997122381&amp;s
>> data=3D7fvZW6dyQ3xlsH0WqW%2BEXnzkmSvNinZwf3oYR%2BOP4U8%3D&am
>> p;reserved=3D0<https://eur01.safelinks.protection.outlook.com/?url=3Dhttps=
%3A
>> %2F%2Flists.trustedfirmware.org%2Fmailman%2Flistinfo%2Fop-tee&amp;dat
>> a=3D02%7C01%7Cpeng.fan%40nxp.com%7C66d0df88519741b75aff08d84fef6af
>> 3%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63734723699712
>> 2381&amp;sdata=3D7fvZW6dyQ3xlsH0WqW%2BEXnzkmSvNinZwf3oYR%2BOP4
>> U8%3D&amp;reserved=3D0>) to gather topics to discuss. If there are no topi=
cs,
>> then there is no meeting.
>>>> Anyone can suggest a topic by replying to this email thread.
>>>>=20
>>>> As a first topic for this first meeting, we want to talk a bit about:
>>>> - Linaro and the relation to TrustedFirmware.org when it comes to OP-TEE.
>>>> - Where to find information.
>>>> - What is on the agenda for the next development cycle.
>>>>=20
>>>> Calendar invitation? I could just send one out here and now, but due
>>>> to Zoom bombing and that it'd be a logistic exercise inviting people,
>>>> I've decided to try another approach and that is to provide the
>>>> connection details in the meeting notes and leave it up to the
>>>> attendees to add it to their own calendars. To try to limit confusion
>>>> I've explicitly added the timezone and a link to
>>>> everytimezone.com<https://eur01.safelinks.protection.outlook.com/?url
>>>>=20
>> =3Dhttp%3A%2F%2Feverytimezone.com%2F&amp;data=3D02%7C01%7Cpeng.fan
>> %40nxp.
>>>>=20
>> com%7C66d0df88519741b75aff08d84fef6af3%7C686ea1d3bc2b4c6fa92cd99
>> c5c301635%7C0%7C0%7C637347236997122381&amp;sdata=3D1sod0wFduTTl
>> zsTmEz%2F0J4qJSIu1e15Js423GmXGyTQ%3D&amp;reserved=3D0> so it should
>> be easy to get the information in your own timezone. If this approach does=
n't
>> turn out to be good, then we will try something different in the future (I
>> understand that canceling or shifting day/time will become a problem).
>>>>=20
>>>> Meeting details:
>>>> ---------------
>>>> Date/time: Thursday Aug 27th(a)16.00<mailto:27th@16.00> (UTC+2)
>>>> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Feve
>>>>=20
>> rytimezone.com%2Fs%2F12a83ab5&amp;data=3D02%7C01%7Cpeng.fan%40nx
>> p.com%7
>>>>=20
>> C66d0df88519741b75aff08d84fef6af3%7C686ea1d3bc2b4c6fa92cd99c5c301
>> 635%
>>>>=20
>> 7C0%7C0%7C637347236997122381&amp;sdata=3D3T5L%2F0kMhBGT%2BTu1F
>> WxClGihm1
>>>>=20
>> mcKIhe52xYJeCUc68%3D&amp;reserved=3D0<https://eur01.safelinks.protectio
>>>>=20
>> n.outlook.com/?url=3Dhttps%3A%2F%2Feverytimezone.com%2Fs%2F12a83ab5
>> &amp
>>>> ;data=3D02%7C01%7Cpeng.fan%40nxp.com%7C66d0df88519741b75aff08d8
>> 4fef6af3
>>>> %7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637347236997
>> 122381&amp;
>>>>=20
>> sdata=3D3T5L%2F0kMhBGT%2BTu1FWxClGihm1mcKIhe52xYJeCUc68%3D&am
>> p;reserved
>>>> =3D0> Invitation/connection details: In the meeting notes Meeting
>>>> notes:
>>>> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fdoc
>>>>=20
>> s.google.com%2Fdocument%2Fd%2F15XsqgGktCrRRWiqyaz-erp_cZykwGjkBk
>> hMD2X
>>>>=20
>> tUlUY&amp;data=3D02%7C01%7Cpeng.fan%40nxp.com%7C66d0df88519741b7
>> 5aff08d
>>>>=20
>> 84fef6af3%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6373472
>> 3699713
>>>>=20
>> 2377&amp;sdata=3Dp03kMVWuiSLGZvtkCpK1tHlW%2Fodgv924%2BW9YrU1ZCT
>> Y%3D&amp
>>>> ;reserved=3D0<https://eur01.safelinks.protection.outlook.com/?url=3Dhttps
>>>> %3A%2F%2Fdocs.google.com%2Fdocument%2Fd%2F15XsqgGktCrRRWiqy
>> az-erp_cZy
>>>>=20
>> kwGjkBkhMD2XtUlUY&amp;data=3D02%7C01%7Cpeng.fan%40nxp.com%7C66d
>> 0df88519
>>>>=20
>> 741b75aff08d84fef6af3%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C
>> 0%7C63
>>>>=20
>> 7347236997132377&amp;sdata=3Dp03kMVWuiSLGZvtkCpK1tHlW%2Fodgv924
>> %2BW9YrU
>>>> 1ZCTY%3D&amp;reserved=3D0>
>>>>=20
>>>> Regards,
>>>> Joakim on behalf of the Linaro OP-TEE team
>>>> --
>>>> OP-TEE mailing list
>>>> OP-TEE(a)lists.trustedfirmware.org<mailto:OP-TEE@lists.trustedfirmware.
>>>> org>
>>>> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flis
>>>>=20
>> ts.trustedfirmware.org%2Fmailman%2Flistinfo%2Fop-tee&amp;data=3D02%7C0
>> 1
>>>> %7Cpeng.fan%40nxp.com%7C66d0df88519741b75aff08d84fef6af3%7C68
>> 6ea1d3bc
>>>>=20
>> 2b4c6fa92cd99c5c301635%7C0%7C0%7C637347236997132377&amp;sdata
>> =3DcgkP%2B
>>>>=20
>> DaYQpahvfbuiWsBoLjrTLayJkta%2F5rMX0tOteI%3D&amp;reserved=3D0<https:/
>> /eu
>>>> r01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.trusted
>>>>=20
>> firmware.org%2Fmailman%2Flistinfo%2Fop-tee&amp;data=3D02%7C01%7Cpen
>> g.fa
>>>>=20
>> n%40nxp.com%7C66d0df88519741b75aff08d84fef6af3%7C686ea1d3bc2b4c
>> 6fa92c
>>>>=20
>> d99c5c301635%7C0%7C0%7C637347236997132377&amp;sdata=3DcgkP%2BD
>> aYQpahvfb
>>>> uiWsBoLjrTLayJkta%2F5rMX0tOteI%3D&amp;reserved=3D0>


--===============0534670479818507889==--

