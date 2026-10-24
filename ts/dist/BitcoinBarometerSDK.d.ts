import { BadgeEntity } from './entity/BadgeEntity';
import { BarometerEntity } from './entity/BarometerEntity';
export type * from './BitcoinBarometerTypes';
import { inspect } from 'node:util';
import type { Context, Feature } from './types';
import { config } from './Config';
import { BitcoinBarometerEntityBase } from './BitcoinBarometerEntityBase';
import { Utility } from './utility/Utility';
import { BaseFeature } from './feature/base/BaseFeature';
declare const stdutil: Utility;
type DirectResult = {
    ok: false;
    err: any;
    status?: undefined;
    headers?: undefined;
    data?: undefined;
} | {
    ok: boolean;
    status: number;
    headers: any;
    data: any;
    err?: any;
};
declare class BitcoinBarometerSDK {
    _mode: string;
    _options: any;
    _utility: Utility;
    _features: Feature[];
    _rootctx: Context;
    constructor(options?: any);
    options(): any;
    utility(): any;
    prepare(fetchargs?: any): Promise<any>;
    direct(fetchargs?: any): Promise<DirectResult>;
    _rawRequest(fetchargs?: any): Promise<DirectResult>;
    graphql(query: string, variables?: any, ctrl?: any): Promise<any>;
    Badge(entopts?: Record<string, any>): BadgeEntity;
    Barometer(entopts?: Record<string, any>): BarometerEntity;
    static test(testoptsarg?: any, sdkoptsarg?: any): BitcoinBarometerSDK;
    tester(testopts?: any, sdkopts?: any): BitcoinBarometerSDK;
    toJSON(): {
        name: string;
    };
    toString(): string;
    [inspect.custom](): string;
}
declare const SDK: typeof BitcoinBarometerSDK;
export { stdutil, config, BaseFeature, BitcoinBarometerEntityBase, BitcoinBarometerSDK, SDK, };
export type { DirectResult };
