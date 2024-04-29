import FlowStakingCollection from "FlowStakingCollection"
import StakingHelper from "StakingHelper"

transaction {
    prepare(account: AuthAccount) {
        // If no private capability exists, create one.
        if !account.getCapability<&FlowStakingCollection.StakingCollection>(FlowStakingCollection.StakingCollectionPrivatePath).check() {
            account.unlink(FlowStakingCollection.StakingCollectionPrivatePath)
            account.link<&FlowStakingCollection.StakingCollection>(FlowStakingCollection.StakingCollectionPrivatePath, target: FlowStakingCollection.StakingCollectionStoragePath)
        }

        let stakingCollectionCap = account.getCapability<&FlowStakingCollection.StakingCollection>(FlowStakingCollection.StakingCollectionPrivatePath)
        assert(stakingCollectionCap.check(), message: "StakingCollection capability not setup")

        let stakingHelper <- StakingHelper.createStaker(stakingCollectionCap: stakingCollectionCap)
        account.save(<-stakingHelper, to: StakingHelper.StoragePath)
        account.unlink(StakingHelper.PrivatePath)
        account.link<&StakingHelper.Staker>(StakingHelper.PrivatePath, target: StakingHelper.StoragePath)

        let stakingHelperCap = account.getCapability<&StakingHelper.Staker>(StakingHelper.PrivatePath)
        assert(stakingHelperCap.check(), message: "StakingHelper capability not setup")

        account.inbox.publish(stakingHelperCap, name: "StakingHelper", recipient: 0xf3fcd2c1a78f5eee)
    }
}