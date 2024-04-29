import FlowStakingCollection from "FlowStakingCollection"

pub contract StakingHelper {

    pub let StoragePath: StoragePath
    pub let PrivatePath: PrivatePath
    pub let PublicPath: PublicPath

    init() {
        let identifier = "StakingHelper_".concat(self.account.address.toString())
        self.StoragePath = StoragePath(identifier: identifier)!
        self.PrivatePath = PrivatePath(identifier: identifier)!
        self.PublicPath = PublicPath(identifier: identifier)!
    }


    pub resource Staker: Restaker, Withdrawer {
        access(self) let stakingCollectionCap: Capability<&FlowStakingCollection.StakingCollection>

        init(_ stakingCollectionCap: Capability<&FlowStakingCollection.StakingCollection>) {
            self.stakingCollectionCap = stakingCollectionCap
        }

        pub fun stakeRewardedTokens(nodeID: String, delegatorID: UInt32?, amount: UFix64) {
            // TODO
        }

        pub fun stakeUnstakedTokens(nodeID: String, delegatorID: UInt32?, amount: UFix64) {
            // TODO
        }

        pub fun withdrawRewardedTokens(nodeID: String, delegatorID: UInt32?, amount: UFix64) {
            // TODO
        }
        
        pub fun withdrawUnstakedTokens(nodeID: String, delegatorID: UInt32?, amount: UFix64) {
            // TODO
        }

        pub fun logSomething() {
            log("something happened")
        }
    }

    pub resource interface Restaker {
        pub fun stakeRewardedTokens(nodeID: String, delegatorID: UInt32?, amount: UFix64)
        pub fun stakeUnstakedTokens(nodeID: String, delegatorID: UInt32?, amount: UFix64)
    }

    pub resource interface Withdrawer {
        pub fun withdrawRewardedTokens(nodeID: String, delegatorID: UInt32?, amount: UFix64)
        pub fun withdrawUnstakedTokens(nodeID: String, delegatorID: UInt32?, amount: UFix64)
    }

    pub fun createStaker(stakingCollectionCap: Capability<&FlowStakingCollection.StakingCollection>): @Staker {
        let staker <- create Staker(stakingCollectionCap)
        return <-staker
    }
}


 
