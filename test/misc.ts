import {strict as assert} from 'assert'
import 'mocha'
import {ChainId, ChainIdVariant, ChainName} from '../src'

describe('misc', function () {
    it('should create chain id', async function () {
        const id = ChainId.from(1)
        assert.equal(
            id.equals('aca376f206b8fc25a6ed44dbdc66547c36c6c33e3a119ffbeaef943642f0e906'),
            true
        )
        assert.equal(id.chainVariant.chainId.chainName, ChainName.EOS)
        const id2 = ChainId.from('beefbeef06b8fc25a6ed44dbdc66547c36c6c33e3a119ffbeaef943642f0e906')
        assert.equal(id2.chainName, ChainName.UNKNOWN)
        assert.equal(id2.chainVariant.variantName, 'chain_id')
        assert.equal(id2.chainVariant.chainId.equals(id2), true)
        assert.throws(() => {
            ChainId.from(99)
        })
        assert.throws(() => {
            ChainIdVariant.from(['chain_alias', 0]).chainId
        })
    })
})
