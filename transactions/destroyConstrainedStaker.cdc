import StakingHelper from "StakingHelper"

transaction {
    prepare(account: AuthAccount) {
        let stakingHelper <- account.load<@StakingHelper.Staker>(from: StakingHelper.StoragePath)!
        destroy stakingHelper
    }
}