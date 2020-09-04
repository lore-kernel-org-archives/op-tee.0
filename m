From: Achin Gupta <Achin.Gupta@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: Linaro OP-TEE Contributions meeting Aug 2020
Date: Fri, 04 Sep 2020 08:12:07 +0000
Message-ID: <160A54DA-0754-4BF1-BAE1-D58015A4A11F@arm.com>
In-Reply-To: <=?utf-8?q?=3CDB6PR0402MB2760C174DCB7115E756A2EA7882D0=40DB6PR04?=
 =?utf-8?q?02MB2760=2Eeurprd04=2Eprod=2Eoutlook=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3872223595724437566=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3872223595724437566==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Peng,

CIL...

> On 4 Sep 2020, at 02:23, Peng Fan <peng.fan@nxp.com> wrote:
>=20
> Not able to receive op-tee(a)lists.trustedfirmware.org confirmation email (=
:!
>=20
> Inline.
>=20
>> Subject: Re: Linaro OP-TEE Contributions meeting Aug 2020
>>=20
>> Hi Peng,
>>=20
>>> On 3 Sep 2020, at 11:14, Peng Fan <peng.fan@nxp.com> wrote:
>>>=20
>>>> Subject: Re: Linaro OP-TEE Contributions meeting Aug 2020
>>>>=20
>>>> Hi Peng,
>>>>=20
>>>>=20
>>>>> On 3 Sep 2020, at 10:34, Jens Wiklander via OP-TEE
>>>> <op-tee@lists.trustedfirmware.org> wrote:
>>>>>=20
>>>>> Hi Peng,
>>>>>=20
>>>>> On Fri, Aug 28, 2020 at 9:10 AM Peng Fan via OP-TEE
>>>>> <op-tee@lists.trustedfirmware.org> wrote:
>>>>>>=20
>>>>>> I was not able to join the meeting. Just wonder for S-EL2, is there
>>>>>> any
>>>> platform supporting it? How to test?
>>>>=20
>>>> Just to be sure, you mean support for running OP-TEE under a
>>>> Hypervisor/SPM in S-EL2?
>>>=20
>>> Yes. Actually I not follow the design decision that supporting
>>> multiple TEEs in secure world. But anyway current OP-TEE support
>>> multiple XEN VMs contributed by EPAM, could this not serve normal world
>> VM per future requirement?
>>=20
>> A couple of things assuming I am understanding your question/concern
>> correctly.
>>=20
>> S-EL2 enables deployment of multiple TEEs. However, this is not the only u=
se
>> case. More importantly, it allows the TEE to access only the physical addr=
ess
>> space it needs to. This helps in mitigating attacks on the Normal world fr=
om
>> the TEE. Furthermore, it enables isolation/separation of a TEE from privil=
eged
>> firmware in EL3 and S-EL2. This helps in compartmentalising the TCB if not
>> reduce its size altogether. So there is the =E2=80=9Cdefense in depth/prin=
ciple of least
>> privilege=E2=80=9D argument too.
>>=20
>> This is the first step in the S-EL2 enablement story for OP-TEE i.e. run O=
P-TEE
>> as a Secure VM under TF-A in EL3 and SPM in S-EL2. We have done some
>> work on the FVP within Arm to enable this and will share it with Jens and
>> publicly soon.
>>=20
>> Multiple-TEEs is a deployment choice. For example, Vendor A has TEE1 on
>> which its Trusted Apps run. Vendor B has TEE2 which implements drivers to
>> Secure peripherals that TAs of TEE1 need. It might not be practical or fea=
sible
>> for Vendor A to port its TAs to TEE2. Hence, the two TEEs need to co-exist=
 and
>> communicate. S-EL2 enables isolation between TEE1 and TEE2. This helps
>> reduce the level of trust that TEE2 should have on TEE1 and vice-versa.
>>=20
>> EPAM=E2=80=99s contribution adds awareness of virtualisation in the Normal=
 world to
>> OP-TEE. This enables OP-TEE to isolate communication channels, data etc
>> associated with one VM from another. Without this isolation, there is a ri=
sk of
>> information of one VM leaking into another. Jens should have more detail on
>> this topic.
>>=20
>> I hope this helps to clarify your concerns. Please let me know.
>=20
> Yeah. Thanks for the clarification.
>=20
> Currently we not have real hardware that support S-EL2, but when we have
> in future, I am afraid that multiple-TEEs + S-EL2 hypervisor will introduce
> more complexity in the whole software stack.
>=20
> And for S-EL2, multiple TEEs, I think SMMU needs also be reconsidered
> how to make sure SMMU could be used in both secure/non-secure world?
>=20
> And for semiconductor company, there are two choices: multiple TEEs, TEEs
> support multiple non-secure VM. Currently I am not sure what is the best
> choice.

It depends entirely on what requirements must be met. The two choices you sta=
te solve different problems. It would help if you could describe the use case=
(s) you have in mind.

You are right that S-EL2 in the CPU relies on support for Secure stage 2 tabl=
es in the SMMU. In the absence of a SMMU,  an equivalent access control mecha=
nism that prevents Secure peripherals assigned to the TEE from accessing the =
entire physical address space is required.

Happy to have chat if that helps.

Cheers,
Achin
=20
>=20
> Thanks,
> Peng.
>=20
>>=20
>> Cheers,
>> Achin
>>=20
>>=20
>>>=20
>>> Thanks,
>>> Peng.
>>>=20
>>>=20
>>>>=20
>>>> Cheers,
>>>> Achin
>>>>=20
>>>>>=20
>>>>> This is tested and developed using FVP as far as I know.
>>>>>=20
>>>>> Cheers,
>>>>> Jens
>>>>>=20
>>>>>>=20
>>>>>> Thanks,
>>>>>> Peng.
>>>>>>=20
>>>>>> From: Joakim Bech [mailto:joakim.bech(a)linaro.org]
>>>>>> Sent: 2020=E5=B9=B48=E6=9C=8827=E6=97=A5 16:21
>>>>>> To: op-tee(a)lists.trustedfirmware.org
>>>>>> Subject: Re: Linaro OP-TEE Contributions meeting Aug 2020
>>>>>>=20
>>>>>> Hi,
>>>>>>=20
>>>>>> Just a friendly reminder, that we have the first public "Linaro
>>>>>> OP-TEE
>>>> Contributions" meeting taking place later today.
>>>>>> 2020-08-27(a)16.00<mailto:2020-08-27@16.00> UTC+2, 1h duration
>> (for
>>>> other timezones, use this URL
>>>> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Feve
>>>> ryti
>> mezone.com%2Fs%2F12a83ab5&amp;data=3D02%7C01%7Cpeng.fan%40nxp.co
>>>>=20
>> m%7C66d0df88519741b75aff08d84fef6af3%7C686ea1d3bc2b4c6fa92cd99c5
>>>>=20
>> c301635%7C0%7C0%7C637347236997122381&amp;sdata=3D3T5L%2F0kMhB
>>>>=20
>> GT%2BTu1FWxClGihm1mcKIhe52xYJeCUc68%3D&amp;reserved=3D0<https://e
>>>>=20
>> ur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Feverytimezone.
>>>>=20
>> com%2Fs%2F12a83ab5&amp;data=3D02%7C01%7Cpeng.fan%40nxp.com%7C6
>>>>=20
>> 6d0df88519741b75aff08d84fef6af3%7C686ea1d3bc2b4c6fa92cd99c5c30163
>>>>=20
>> 5%7C0%7C0%7C637347236997122381&amp;sdata=3D3T5L%2F0kMhBGT%2BT
>>>> u1FWxClGihm1mcKIhe52xYJeCUc68%3D&amp;reserved=3D0>). Connection
>> details
>>>> and etc can be found in the email below.
>>>>>>=20
>>>>>> This time I've also included more people on BCC who might not have
>>>> subscribed to the
>>>> <op-tee(a)lists.trustedfirmware.org<mailto:op-tee@lists.trustedfirmware
>>>> .org
>>>>>> list.
>>>>>>=20
>>>>>> Regards,
>>>>>> Joakim
>>>>>>=20
>>>>>> On Wed, 19 Aug 2020 at 15:52, Joakim Bech via OP-TEE
>>>> <op-tee(a)lists.trustedfirmware.org<mailto:op-tee@lists.trustedfirmware
>>>> .org
>>>>>> wrote:
>>>>>> Hi,
>>>>>>=20
>>>>>> As part of opening up Linaro projects to the general public we plan
>>>>>> to have an open monthly meeting where we discuss Linaro's
>>>>>> activities
>>>> around OP-TEE.
>>>>>> The way that we've planned to do this is that we send out an email
>>>>>> to this email list
>>>>>>=20
>>>> (https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fli
>>>> sts.tr
>>>>=20
>> ustedfirmware.org%2Fmailman%2Flistinfo%2Fop-tee&amp;data=3D02%7C01%
>>>>=20
>> 7Cpeng.fan%40nxp.com%7C66d0df88519741b75aff08d84fef6af3%7C686ea1
>>>>=20
>> d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637347236997122381&amp;s
>>>>=20
>> data=3D7fvZW6dyQ3xlsH0WqW%2BEXnzkmSvNinZwf3oYR%2BOP4U8%3D&am
>>>> p;reserved=3D0<https://eur01.safelinks.protection.outlook.com/?url=3Dhttp
>>>> s%3A
>>>> %2F%2Flists.trustedfirmware.org%2Fmailman%2Flistinfo%2Fop-tee&amp;
>> dat
>>>>=20
>> a=3D02%7C01%7Cpeng.fan%40nxp.com%7C66d0df88519741b75aff08d84fef6af
>>>>=20
>> 3%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63734723699712
>>>>=20
>> 2381&amp;sdata=3D7fvZW6dyQ3xlsH0WqW%2BEXnzkmSvNinZwf3oYR%2BOP4
>>>> U8%3D&amp;reserved=3D0>) to gather topics to discuss. If there are no
>>>> topics, then there is no meeting.
>>>>>> Anyone can suggest a topic by replying to this email thread.
>>>>>>=20
>>>>>> As a first topic for this first meeting, we want to talk a bit about:
>>>>>> - Linaro and the relation to TrustedFirmware.org when it comes to
>> OP-TEE.
>>>>>> - Where to find information.
>>>>>> - What is on the agenda for the next development cycle.
>>>>>>=20
>>>>>> Calendar invitation? I could just send one out here and now, but
>>>>>> due to Zoom bombing and that it'd be a logistic exercise inviting
>>>>>> people, I've decided to try another approach and that is to provide
>>>>>> the connection details in the meeting notes and leave it up to the
>>>>>> attendees to add it to their own calendars. To try to limit
>>>>>> confusion I've explicitly added the timezone and a link to
>>>>>> everytimezone.com<https://eur01.safelinks.protection.outlook.com/?u
>>>>>> rl
>>>>>>=20
>>>>=20
>> =3Dhttp%3A%2F%2Feverytimezone.com%2F&amp;data=3D02%7C01%7Cpeng.fan
>>>> %40nxp.
>>>>>>=20
>>>>=20
>> com%7C66d0df88519741b75aff08d84fef6af3%7C686ea1d3bc2b4c6fa92cd99
>>>>=20
>> c5c301635%7C0%7C0%7C637347236997122381&amp;sdata=3D1sod0wFduTTl
>>>> zsTmEz%2F0J4qJSIu1e15Js423GmXGyTQ%3D&amp;reserved=3D0> so it
>> should be
>>>> easy to get the information in your own timezone. If this approach
>>>> doesn't turn out to be good, then we will try something different in
>>>> the future (I understand that canceling or shifting day/time will become=
 a
>> problem).
>>>>>>=20
>>>>>> Meeting details:
>>>>>> ---------------
>>>>>> Date/time: Thursday Aug 27th(a)16.00<mailto:27th@16.00> (UTC+2)
>>>>>> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fe
>>>>>> ve
>>>>>>=20
>>>>=20
>> rytimezone.com%2Fs%2F12a83ab5&amp;data=3D02%7C01%7Cpeng.fan%40nx
>>>> p.com%7
>>>>>>=20
>>>>=20
>> C66d0df88519741b75aff08d84fef6af3%7C686ea1d3bc2b4c6fa92cd99c5c301
>>>> 635%
>>>>>>=20
>>>>=20
>> 7C0%7C0%7C637347236997122381&amp;sdata=3D3T5L%2F0kMhBGT%2BTu1F
>>>> WxClGihm1
>>>>>>=20
>>>>=20
>> mcKIhe52xYJeCUc68%3D&amp;reserved=3D0<https://eur01.safelinks.protectio
>>>>=20
>> n.outlook.com/?url=3Dhttps%3A%2F%2Feur01.safelinks.protectio%2F&amp;dat
>>>>=20
>> a=3D02%7C01%7Cpeng.fan%40nxp.com%7Cd80f28c0d30846ceea4e08d84ffde0
>> da%7C6
>>>>=20
>> 86ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C1%7C637347299106238571&
>> amp;sdat
>>>>=20
>> a=3DbKq%2FbdGJIOXSvusvLISHgHXtaXfFE4r5WI0OajZziHg%3D&amp;reserved=3D0
>>>>>>=20
>>>>=20
>> n.outlook.com/?url=3Dhttps%3A%2F%2Feverytimezone.com%2Fs%2F12a83ab5
>>>> &amp
>>>>>> ;data=3D02%7C01%7Cpeng.fan%40nxp.com%7C66d0df88519741b75aff08
>> d8
>>>> 4fef6af3
>>>>>> %7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6373472369
>> 97
>>>> 122381&amp;
>>>>>>=20
>>>>=20
>> sdata=3D3T5L%2F0kMhBGT%2BTu1FWxClGihm1mcKIhe52xYJeCUc68%3D&am
>>>> p;reserved
>>>>>> =3D0> Invitation/connection details: In the meeting notes Meeting
>>>>>> notes:
>>>>>> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fd
>>>>>> oc
>>>>>>=20
>>>>=20
>> s.google.com%2Fdocument%2Fd%2F15XsqgGktCrRRWiqyaz-erp_cZykwGjkBk
>>>> hMD2X
>>>>>>=20
>>>>=20
>> tUlUY&amp;data=3D02%7C01%7Cpeng.fan%40nxp.com%7C66d0df88519741b7
>>>> 5aff08d
>>>>>>=20
>>>>=20
>> 84fef6af3%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6373472
>>>> 3699713
>>>>>>=20
>>>>=20
>> 2377&amp;sdata=3Dp03kMVWuiSLGZvtkCpK1tHlW%2Fodgv924%2BW9YrU1ZCT
>>>> Y%3D&amp
>>>>>> ;reserved=3D0<https://eur01.safelinks.protection.outlook.com/?url=3Dhtt
>>>>>>=20
>> ps %3A%2F%2Fdocs.google.com%2Fdocument%2Fd%2F15XsqgGktCrRRWiqy
>>>> az-erp_cZy
>>>>>>=20
>>>>=20
>> kwGjkBkhMD2XtUlUY&amp;data=3D02%7C01%7Cpeng.fan%40nxp.com%7C66d
>>>> 0df88519
>>>>>>=20
>>>>=20
>> 741b75aff08d84fef6af3%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C
>>>> 0%7C63
>>>>>>=20
>>>>=20
>> 7347236997132377&amp;sdata=3Dp03kMVWuiSLGZvtkCpK1tHlW%2Fodgv924
>>>> %2BW9YrU
>>>>>> 1ZCTY%3D&amp;reserved=3D0>
>>>>>>=20
>>>>>> Regards,
>>>>>> Joakim on behalf of the Linaro OP-TEE team
>>>>>> --
>>>>>> OP-TEE mailing list
>>>>>>=20
>> OP-TEE(a)lists.trustedfirmware.org<mailto:OP-TEE@lists.trustedfirmware.
>>>>>> org>
>>>>>> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fl
>>>>>> is
>>>>>>=20
>>>>=20
>> ts.trustedfirmware.org%2Fmailman%2Flistinfo%2Fop-tee&amp;data=3D02%7C0
>>>> 1
>>>>>> %7Cpeng.fan%40nxp.com%7C66d0df88519741b75aff08d84fef6af3%7C
>> 68
>>>> 6ea1d3bc
>>>>>>=20
>>>>=20
>> 2b4c6fa92cd99c5c301635%7C0%7C0%7C637347236997132377&amp;sdata
>>>> =3DcgkP%2B
>>>>>>=20
>>>>=20
>> DaYQpahvfbuiWsBoLjrTLayJkta%2F5rMX0tOteI%3D&amp;reserved=3D0<https:/
>>>> /eu
>>>>>> r01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.trust
>>>>>> ed
>>>>>>=20
>>>>=20
>> firmware.org%2Fmailman%2Flistinfo%2Fop-tee&amp;data=3D02%7C01%7Cpen
>>>> g.fa
>>>>>>=20
>>>>=20
>> n%40nxp.com%7C66d0df88519741b75aff08d84fef6af3%7C686ea1d3bc2b4c
>>>> 6fa92c
>>>>>>=20
>>>>=20
>> d99c5c301635%7C0%7C0%7C637347236997132377&amp;sdata=3DcgkP%2BD
>>>> aYQpahvfb
>>>>>> uiWsBoLjrTLayJkta%2F5rMX0tOteI%3D&amp;reserved=3D0>


--===============3872223595724437566==--

