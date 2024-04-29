import StakingHelper from "StakingHelper"

transaction {
    prepare(account: AuthAccount) {
        let stakingHelperCap = account.getCapability<&StakingHelper.Staker>(StakingHelper.PrivatePath)
        stakingHelperCap.borrow()!.logSomething()
    }
}