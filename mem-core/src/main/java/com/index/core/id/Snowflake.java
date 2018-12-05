package com.index.core.id;

/**
 *
 * 序号生成器： 64bit long类型 使用snowflake算法
 *
 * 0 - 0000000000 0000000000 0000000000 0000000000 0 - 00000 - 00000 - 000000000000
 *
 * 1bit标记    41bit 时间戳（当前时间到初始时间差的毫秒数）       5bit机器号  5bit集群号  12bit的内部序号
 *
 *
 * 该位数设计支持 32个集群，每个集群32个主机， 每毫秒 4096个序号的并发量， 序号长度为 2^41 与等于67年
 *
 */
public class Snowflake {

    /**
     * 2018-01-01 00:00:00.000 的时间戳
     */
    private long startTimestamp = 1514764800000L;

    private long workIdBit = 5L;

    private long groupIdBit = 5L;

    private long sequenceBit = 12L;

    private long maxWorkId = -1L ^ (-1L << workIdBit);

    private long maxGroupId = -1L ^ (-1L << groupIdBit);

    private long maxSequence = -1L ^ (-1L << sequenceBit);

    private long groupIdShift = sequenceBit;

    private long workIdShift = sequenceBit + groupIdBit;

    private long timestampShift = sequenceBit + groupIdBit + workIdBit;

    private long lastTimestamp = -1L;

    private long sequence = 0L;

    private long workId;

    private long groupId;

    public Snowflake(long workId, long groupId) {
        if(workId > maxWorkId || workId < 0) {
            throw new RuntimeException("workId必须在0-31之间");
        }
        if(groupId > maxGroupId || groupId < 0) {
            throw new RuntimeException("groupId必须在0-31之间");
        }

        this.workId = workId;
        this.groupId = groupId;
    }

    /**
     * 获取下个序号，线程安全
     * @return
     */
    public synchronized long next() {

        long timestamp = this.genTimestamp();

        if(timestamp < lastTimestamp) {
            throw new RuntimeException("系统时间顺序发生错误，请检查系统时间是否设置正确");
        }

        if(timestamp == lastTimestamp) {

            sequence = (sequence + 1L) & maxSequence;

            if(sequence == 0L) {
                timestamp = this.untilNextMillis(lastTimestamp);
            }

        } else {
            sequence = 0L;
        }

        lastTimestamp = timestamp;

        return ((timestamp - startTimestamp) << timestampShift)
                | (workId << workIdShift)
                | (groupId << groupIdShift)
                | (sequence);
    }


    /**
     * 获取后一毫秒的时间戳
     * @param oldtimestamp
     * @return
     */
    private long untilNextMillis(long oldtimestamp) {
        long newtimestamp = this.genTimestamp();
        while(oldtimestamp >= newtimestamp) {
            newtimestamp = this.genTimestamp();
        }
        return newtimestamp;
    }

    /**
     * 生成当前时间戳
     * @return
     */
    private long genTimestamp() {
        return System.currentTimeMillis();
    }


}
