From: Joakim Bech <joakim.bech@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: reference keymint & gatekeeper TAs
Date: Wed, 14 Jun 2023 14:23:59 +0200
Message-ID: 
 <CA+EyddZDkbnUpUcDTV3o9G59-unPxCzE0KvObUcZw3Yjou6wZQ@mail.gmail.com>
In-Reply-To: <=?utf-8?q?=3CPH7PR15MB6164373F61F46C09CFBEBF7DCC54A=40PH7PR15MB?=
 =?utf-8?q?6164=2Enamprd15=2Eprod=2Eoutlook=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6006743246396367904=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6006743246396367904==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi Nagendra,

On Mon, Jun 12, 2023 at 6:52 PM Nagendra Modadugu via OP-TEE <
op-tee@lists.trustedfirmware.org> wrote:

> I'm writing to get further information regarding the support roadmap for
> OP-TEE based TA's - specifically keymint and gatekeeper.
>
> The implementations I could find are here:
> https://github.com/linaro-swg/kmgk, and was wondering whether these are
> supported?
>
Yes, this is the (official) Keymaster & Gatekeeper implementation for
OP-TEE. Having said that, it's not maintained any longer and as you can see
in the git comments, it dates back to roughly 2021 when we last put efforts
into this code base. In addition to that, there are newer revisions of
KM&GK as well (
https://source.android.com/docs/security/features/authentication), so there
would need to be some time spent on updating the code to adhere to newer
revisions.

I just want to stress that the reason we aren't maintaining it isn't
because we don't want to. Other factors also come into play in this
scenario, ... priorities, staffing, interest from community etc.


>
> Please respond off list if you find that would be more appropriate for
> discussion.
>
> thanks.
>
>
-- 
Regards,
Joakim

--===============6006743246396367904==--

