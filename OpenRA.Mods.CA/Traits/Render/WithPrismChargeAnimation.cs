#region Copyright & License Information
/**
 * Copyright (c) The OpenRA Combined Arms Developers (see CREDITS).
 * This file is part of OpenRA Combined Arms, which is free software.
 * It is made available to you under the terms of the GNU General Public License
 * as published by the Free Software Foundation, either version 3 of the License,
 * or (at your option) any later version. For more information, see COPYING.
 */
#endregion

using System.Linq;
using OpenRA.Mods.Common.Traits.Render;
using OpenRA.Traits;

namespace OpenRA.Mods.CA.Traits.Render
{
	[Desc("This actor displays a charge-up animation before firing.")]
	public class WithPrismChargeAnimationInfo : TraitInfo, Requires<WithSpriteBodyInfo>, Requires<RenderSpritesInfo>
	{
		[SequenceReference]
		[Desc("Sequence to use for charge animation.")]
		public readonly string ChargeSequence = "active";

		[Desc("Which sprite body to play the animation on.")]
		public readonly string Body = "body";

		public override object Create(ActorInitializer init) { return new WithPrismChargeAnimation(init, this); }
	}

	public class WithPrismChargeAnimation : INotifyPrismCharging
	{
		readonly WithPrismChargeAnimationInfo info;
		readonly WithSpriteBody wsb;

		public WithPrismChargeAnimation(ActorInitializer init, WithPrismChargeAnimationInfo info)
		{
			this.info = info;
			wsb = init.Self.TraitsImplementing<WithSpriteBody>().Single(w => w.Info.Name == info.Body);
		}

		void INotifyPrismCharging.Charging(Actor self, in Target target)
		{
			wsb.PlayCustomAnimation(self, info.ChargeSequence, () => wsb.CancelCustomAnimation(self));
		}
	}
}
