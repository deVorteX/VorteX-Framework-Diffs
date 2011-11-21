.class public final Lcom/android/internal/app/ShutdownThread;
.super Ljava/lang/Thread;
.source "ShutdownThread.java"


# static fields
#the value of this static final field might be set in the static constructor
.field private static final DEBUG_KPI:Z = false

.field private static final MAX_BROADCAST_TIME:I = 0x2710

.field private static final MAX_NUM_PHONE_STATE_READS:I = 0x10

.field private static final MAX_SHUTDOWN_WAIT_TIME:I = 0x4e20

.field private static final PHONE_STATE_POLL_SLEEP_MSEC:I = 0x1f4

.field public static final SHUTDOWN_ACTION_PROPERTY:Ljava/lang/String; = "sys.shutdown.requested"

.field private static final SHUTDOWN_VIBRATE_MS:I = 0x1f4

.field private static final TAG:Ljava/lang/String; = "ShutdownThread"

.field public static mReboot:I

.field private static mReboot:Z

.field private static mRebootReason:Ljava/lang/String;

.field private static mStartShutdownTime:J

.field private static final sInstance:Lcom/android/internal/app/ShutdownThread;

.field private static sIsStarted:Z

.field private static sIsStartedGuard:Ljava/lang/Object;

.field private static sSystemReady:Z

.field private static final sSystemReadySync:Ljava/lang/Object;


# instance fields
.field private mActionDone:Z

.field private final mActionDoneSync:Ljava/lang/Object;

.field private mContext:Landroid/content/Context;

.field private mHandler:Landroid/os/Handler;

.field private mPhoneStateListener:Landroid/telephony/PhoneStateListener;

.field private mPowerManager:Landroid/os/PowerManager;

.field private mRadioOffSync:Ljava/lang/Object;

.field private mTelephonyManager:Landroid/telephony/TelephonyManager;

.field private mWakeLock:Landroid/os/PowerManager$WakeLock;


# direct methods
.method static constructor <clinit>()V
    .registers 2

    .prologue
    const/4 v1, 0x0

    .line 71
    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    sput-object v0, Lcom/android/internal/app/ShutdownThread;->sIsStartedGuard:Ljava/lang/Object;

    .line 72
    sput-boolean v1, Lcom/android/internal/app/ShutdownThread;->sIsStarted:Z

    .line 81
    new-instance v0, Lcom/android/internal/app/ShutdownThread;

    invoke-direct {v0}, Lcom/android/internal/app/ShutdownThread;-><init>()V

    sput-object v0, Lcom/android/internal/app/ShutdownThread;->sInstance:Lcom/android/internal/app/ShutdownThread;

    .line 85
    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    sput-object v0, Lcom/android/internal/app/ShutdownThread;->sSystemReadySync:Ljava/lang/Object;

    .line 86
    sput-boolean v1, Lcom/android/internal/app/ShutdownThread;->sSystemReady:Z

    .line 105
    const-string v0, "debug.kpi"

    invoke-static {v0, v1}, Landroid/os/SystemProperties;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    sput-boolean v0, Lcom/android/internal/app/ShutdownThread;->DEBUG_KPI:Z

    .line 109
    const-wide/16 v0, 0x0

    sput-wide v0, Lcom/android/internal/app/ShutdownThread;->mStartShutdownTime:J

    return-void
.end method

.method private constructor <init>()V
    .registers 3

    .prologue
    const/4 v1, 0x0

    .line 112
    invoke-direct {p0}, Ljava/lang/Thread;-><init>()V

    .line 90
    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    iput-object v0, p0, Lcom/android/internal/app/ShutdownThread;->mActionDoneSync:Ljava/lang/Object;

    .line 99
    iput-object v1, p0, Lcom/android/internal/app/ShutdownThread;->mTelephonyManager:Landroid/telephony/TelephonyManager;

    .line 100
    iput-object v1, p0, Lcom/android/internal/app/ShutdownThread;->mPhoneStateListener:Landroid/telephony/PhoneStateListener;

    .line 101
    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    iput-object v0, p0, Lcom/android/internal/app/ShutdownThread;->mRadioOffSync:Ljava/lang/Object;

    .line 113
    return-void
.end method

.method static synthetic access$000(Landroid/content/Context;)V
    .registers 1
    .parameter "x0"

    .prologue
    .line 58
    invoke-static {p0}, Lcom/android/internal/app/ShutdownThread;->beginShutdownSequence(Landroid/content/Context;)V

    return-void
.end method

.method static synthetic access$100(Lcom/android/internal/app/ShutdownThread;)Ljava/lang/Object;
    .registers 2
    .parameter "x0"

    .prologue
    .line 58
    iget-object v0, p0, Lcom/android/internal/app/ShutdownThread;->mRadioOffSync:Ljava/lang/Object;

    return-object v0
.end method

.method private static beginShutdownSequence(Landroid/content/Context;)V
    .registers 9
    .parameter "context"

    .prologue
    const/4 v6, 0x0

    const/4 v4, 0x1

    const-string v7, "ShutdownThread"

    .line 174
    sget-object v2, Lcom/android/internal/app/ShutdownThread;->sIsStartedGuard:Ljava/lang/Object;

    monitor-enter v2

    .line 175
    :try_start_7
    sget-boolean v3, Lcom/android/internal/app/ShutdownThread;->sIsStarted:Z

    if-eqz v3, :cond_14

    .line 176
    const-string v3, "ShutdownThread"

    const-string v4, "Request to shutdown already running, returning."

    invoke-static {v3, v4}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 177
    monitor-exit v2

    .line 220
    .end local p0
    :goto_13
    return-void

    .line 179
    .restart local p0
    :cond_14
    const/4 v3, 0x1

    sput-boolean v3, Lcom/android/internal/app/ShutdownThread;->sIsStarted:Z

    .line 180
    monitor-exit v2
    :try_end_18
    .catchall {:try_start_7 .. :try_end_18} :catchall_aa

    .line 183
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    sput-wide v2, Lcom/android/internal/app/ShutdownThread;->mStartShutdownTime:J

    .line 186
    sget-object v2, Lcom/android/internal/app/ShutdownThread;->sInstance:Lcom/android/internal/app/ShutdownThread;

    invoke-direct {v2, p0}, Lcom/android/internal/app/ShutdownThread;->prepare(Landroid/content/Context;)V

    .line 190
    new-instance v1, Landroid/app/ProgressDialog;

    invoke-direct {v1, p0}, Landroid/app/ProgressDialog;-><init>(Landroid/content/Context;)V

    .line 191
    .local v1, pd:Landroid/app/ProgressDialog;
    const v2, 0x1040127

    invoke-virtual {p0, v2}, Landroid/content/Context;->getText(I)Ljava/lang/CharSequence;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/app/ProgressDialog;->setTitle(Ljava/lang/CharSequence;)V

    .line 192
    const v2, 0x1040128

    invoke-virtual {p0, v2}, Landroid/content/Context;->getText(I)Ljava/lang/CharSequence;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/app/ProgressDialog;->setMessage(Ljava/lang/CharSequence;)V

    .line 193
    invoke-virtual {v1, v4}, Landroid/app/ProgressDialog;->setIndeterminate(Z)V

    .line 194
    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Landroid/app/ProgressDialog;->setCancelable(Z)V

    .line 195
    invoke-virtual {v1}, Landroid/app/ProgressDialog;->getWindow()Landroid/view/Window;

    move-result-object v2

    const/16 v3, 0x7d9

    invoke-virtual {v2, v3}, Landroid/view/Window;->setType(I)V

    .line 196
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    const v3, 0x10d0001

    invoke-virtual {v2, v3}, Landroid/content/res/Resources;->getBoolean(I)Z

    move-result v2

    if-nez v2, :cond_61

    .line 198
    invoke-virtual {v1}, Landroid/app/ProgressDialog;->getWindow()Landroid/view/Window;

    move-result-object v2

    const/4 v3, 0x4

    invoke-virtual {v2, v3}, Landroid/view/Window;->addFlags(I)V

    .line 201
    :cond_61
    invoke-virtual {v1}, Landroid/app/ProgressDialog;->show()V

    .line 204
    sget-object v2, Lcom/android/internal/app/ShutdownThread;->sInstance:Lcom/android/internal/app/ShutdownThread;

    iput-object p0, v2, Lcom/android/internal/app/ShutdownThread;->mContext:Landroid/content/Context;

    .line 205
    sget-object v2, Lcom/android/internal/app/ShutdownThread;->sInstance:Lcom/android/internal/app/ShutdownThread;

    const-string/jumbo v3, "power"

    invoke-virtual {p0, v3}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p0

    .end local p0
    check-cast p0, Landroid/os/PowerManager;

    iput-object p0, v2, Lcom/android/internal/app/ShutdownThread;->mPowerManager:Landroid/os/PowerManager;

    .line 206
    sget-object v2, Lcom/android/internal/app/ShutdownThread;->sInstance:Lcom/android/internal/app/ShutdownThread;

    iput-object v6, v2, Lcom/android/internal/app/ShutdownThread;->mWakeLock:Landroid/os/PowerManager$WakeLock;

    .line 207
    sget-object v2, Lcom/android/internal/app/ShutdownThread;->sInstance:Lcom/android/internal/app/ShutdownThread;

    iget-object v2, v2, Lcom/android/internal/app/ShutdownThread;->mPowerManager:Landroid/os/PowerManager;

    invoke-virtual {v2}, Landroid/os/PowerManager;->isScreenOn()Z

    move-result v2

    if-eqz v2, :cond_9a

    .line 209
    :try_start_83
    sget-object v2, Lcom/android/internal/app/ShutdownThread;->sInstance:Lcom/android/internal/app/ShutdownThread;

    sget-object v3, Lcom/android/internal/app/ShutdownThread;->sInstance:Lcom/android/internal/app/ShutdownThread;

    iget-object v3, v3, Lcom/android/internal/app/ShutdownThread;->mPowerManager:Landroid/os/PowerManager;

    const/16 v4, 0x1a

    const-string v5, "Shutdown"

    invoke-virtual {v3, v4, v5}, Landroid/os/PowerManager;->newWakeLock(ILjava/lang/String;)Landroid/os/PowerManager$WakeLock;

    move-result-object v3

    iput-object v3, v2, Lcom/android/internal/app/ShutdownThread;->mWakeLock:Landroid/os/PowerManager$WakeLock;

    .line 211
    sget-object v2, Lcom/android/internal/app/ShutdownThread;->sInstance:Lcom/android/internal/app/ShutdownThread;

    iget-object v2, v2, Lcom/android/internal/app/ShutdownThread;->mWakeLock:Landroid/os/PowerManager$WakeLock;

    invoke-virtual {v2}, Landroid/os/PowerManager$WakeLock;->acquire()V
    :try_end_9a
    .catch Ljava/lang/SecurityException; {:try_start_83 .. :try_end_9a} :catch_ad

    .line 217
    :cond_9a
    :goto_9a
    sget-object v2, Lcom/android/internal/app/ShutdownThread;->sInstance:Lcom/android/internal/app/ShutdownThread;

    new-instance v3, Lcom/android/internal/app/ShutdownThread$2;

    invoke-direct {v3}, Lcom/android/internal/app/ShutdownThread$2;-><init>()V

    iput-object v3, v2, Lcom/android/internal/app/ShutdownThread;->mHandler:Landroid/os/Handler;

    .line 219
    sget-object v2, Lcom/android/internal/app/ShutdownThread;->sInstance:Lcom/android/internal/app/ShutdownThread;

    invoke-virtual {v2}, Lcom/android/internal/app/ShutdownThread;->start()V

    goto/16 :goto_13

    .line 180
    .end local v1           #pd:Landroid/app/ProgressDialog;
    .restart local p0
    :catchall_aa
    move-exception v3

    :try_start_ab
    monitor-exit v2
    :try_end_ac
    .catchall {:try_start_ab .. :try_end_ac} :catchall_aa

    throw v3

    .line 212
    .end local p0
    .restart local v1       #pd:Landroid/app/ProgressDialog;
    :catch_ad
    move-exception v2

    move-object v0, v2

    .line 213
    .local v0, e:Ljava/lang/SecurityException;
    const-string v2, "ShutdownThread"

    const-string v2, "No permission to acquire wake lock"

    invoke-static {v7, v2, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 214
    sget-object v2, Lcom/android/internal/app/ShutdownThread;->sInstance:Lcom/android/internal/app/ShutdownThread;

    iput-object v6, v2, Lcom/android/internal/app/ShutdownThread;->mWakeLock:Landroid/os/PowerManager$WakeLock;

    goto :goto_9a
.end method

.method private prepare(Landroid/content/Context;)V
    .registers 5
    .parameter "context"

    .prologue
    .line 232
    const-string/jumbo v0, "phone"

    invoke-virtual {p1, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/telephony/TelephonyManager;

    iput-object v0, p0, Lcom/android/internal/app/ShutdownThread;->mTelephonyManager:Landroid/telephony/TelephonyManager;

    .line 233
    new-instance v0, Lcom/android/internal/app/ShutdownThread$3;

    invoke-direct {v0, p0}, Lcom/android/internal/app/ShutdownThread$3;-><init>(Lcom/android/internal/app/ShutdownThread;)V

    iput-object v0, p0, Lcom/android/internal/app/ShutdownThread;->mPhoneStateListener:Landroid/telephony/PhoneStateListener;

    .line 244
    iget-object v0, p0, Lcom/android/internal/app/ShutdownThread;->mTelephonyManager:Landroid/telephony/TelephonyManager;

    iget-object v1, p0, Lcom/android/internal/app/ShutdownThread;->mPhoneStateListener:Landroid/telephony/PhoneStateListener;

    const/4 v2, 0x1

    invoke-virtual {v0, v1, v2}, Landroid/telephony/TelephonyManager;->listen(Landroid/telephony/PhoneStateListener;I)V

    .line 245
    return-void
.end method

.method public static reboot(Landroid/content/Context;Ljava/lang/String;Z)V
    .registers 4
    .parameter "context"
    .parameter "reason"
    .parameter "confirm"

    .prologue
    .line 168
    const/4 v0, 0x1

    sput-boolean v0, Lcom/android/internal/app/ShutdownThread;->mReboot:Z

    .line 169
    sput-object p1, Lcom/android/internal/app/ShutdownThread;->mRebootReason:Ljava/lang/String;

    .line 170
    invoke-static {p0, p2}, Lcom/android/internal/app/ShutdownThread;->shutdown(Landroid/content/Context;Z)V

    .line 171
    return-void
.end method

.method public static rebootOrShutdown(ZLjava/lang/String;)V
    .registers 8
    .parameter "reboot"
    .parameter "reason"

    .prologue
    const-string v5, "Performing low-level shutdown..."

    const-string v4, "ShutdownThread"

    .line 474
    sget-boolean v2, Lcom/android/internal/app/ShutdownThread;->DEBUG_KPI:Z

    if-eqz v2, :cond_f

    .line 475
    const-string v2, "KPI-SHUTDOWN-7"

    const-string v3, "Shutting down vibrator starts"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 478
    :cond_f
    if-eqz p0, :cond_76

    .line 479
    const-string v2, "ShutdownThread"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Rebooting, reason: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v4, v2}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 481
    :try_start_29
    invoke-static {p1}, Landroid/os/Power;->reboot(Ljava/lang/String;)V
    :try_end_2c
    .catch Ljava/lang/Exception; {:try_start_29 .. :try_end_2c} :catch_6d

    .line 504
    :goto_2c
    sget-boolean v2, Lcom/android/internal/app/ShutdownThread;->DEBUG_KPI:Z

    if-eqz v2, :cond_91

    .line 505
    const-string v2, "KPI-SHUTDOWN-8"

    const-string v3, "Performing low-level shutdown..."

    invoke-static {v2, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 511
    :goto_37
    sget v1, Lcom/android/internal/app/ShutdownThread;->mReboot:I

    const/4 v2, 0x1

    if-eq v1, v2, :cond_42

    const/4 v2, 0x2

    if-eq v1, v2, :cond_48

    invoke-static {}, Landroid/os/Power;->shutdown()V

    :cond_42
    const-string v4, "now"

    invoke-static {v4}, Landroid/os/Power;->reboot(Ljava/lang/String;)V

    return-void

    :cond_48
    const-string v4, "now"

    const/4 v2, 0x3

    new-array v0, v2, [Ljava/lang/String;

    const/4 v2, 0x0

    const-string/jumbo v3, "su"

    aput-object v3, v0, v2

    const/4 v2, 0x1

    const-string v3, "-c"

    aput-object v3, v0, v2

    const/4 v2, 0x2

    const-string v1, "echo 1 > /data/.recovery_mode ; "

    aput-object v1, v0, v2

    .local v0, args:[Ljava/lang/String;
    invoke-static {}, Ljava/lang/Runtime;->getRuntime()Ljava/lang/Runtime;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/Runtime;->exec([Ljava/lang/String;)Ljava/lang/Process;

    move-result-object v1

    .local v1, proc:Ljava/lang/Process;
    invoke-virtual {v1}, Ljava/lang/Process;->waitFor()I

    invoke-static {v4}, Landroid/os/Power;->reboot(Ljava/lang/String;)V

    return-void

    .line 512
    return-void

    .line 482
    :catch_6d
    move-exception v0

    .line 483
    .local v0, e:Ljava/lang/Exception;
    const-string v2, "ShutdownThread"

    const-string v2, "Reboot failed, will attempt shutdown instead"

    invoke-static {v4, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_2c

    .line 487
    .end local v0           #e:Ljava/lang/Exception;
    :cond_76
    new-instance v1, Landroid/os/Vibrator;

    invoke-direct {v1}, Landroid/os/Vibrator;-><init>()V

    .line 489
    .local v1, vibrator:Landroid/os/Vibrator;
    const-wide/16 v2, 0x1f4

    :try_start_7d
    invoke-virtual {v1, v2, v3}, Landroid/os/Vibrator;->vibrate(J)V
    :try_end_80
    .catch Ljava/lang/Exception; {:try_start_7d .. :try_end_80} :catch_88

    .line 497
    :goto_80
    const-wide/16 v2, 0x1f4

    :try_start_82
    invoke-static {v2, v3}, Ljava/lang/Thread;->sleep(J)V
    :try_end_85
    .catch Ljava/lang/InterruptedException; {:try_start_82 .. :try_end_85} :catch_86

    goto :goto_2c

    .line 498
    :catch_86
    move-exception v2

    goto :goto_2c

    .line 490
    :catch_88
    move-exception v0

    .line 492
    .restart local v0       #e:Ljava/lang/Exception;
    const-string v2, "ShutdownThread"

    const-string v2, "Failed to vibrate during shutdown."

    invoke-static {v4, v2, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_80

    .line 508
    .end local v0           #e:Ljava/lang/Exception;
    .end local v1           #vibrator:Landroid/os/Vibrator;
    :cond_91
    const-string v2, "ShutdownThread"

    const-string v2, "Performing low-level shutdown..."

    invoke-static {v4, v5}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_37
.end method

.method public static shutdown(Landroid/content/Context;Z)V
    .registers 6
    .parameter "context"
    .parameter "confirm"

    .prologue
    const-string v3, "ShutdownThread"

    .line 126
    sget-object v1, Lcom/android/internal/app/ShutdownThread;->sIsStartedGuard:Ljava/lang/Object;

    monitor-enter v1

    .line 127
    :try_start_5
    sget-boolean v2, Lcom/android/internal/app/ShutdownThread;->sIsStarted:Z

    if-eqz v2, :cond_12

    .line 128
    const-string v2, "ShutdownThread"

    const-string v3, "Request to shutdown already running, returning."

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 129
    monitor-exit v1

    .line 156
    :goto_11
    return-void

    .line 131
    :cond_12
    monitor-exit v1
    :try_end_13
    .catchall {:try_start_5 .. :try_end_13} :catchall_70

    .line 133
    const-string v1, "ShutdownThread"

    const-string v1, "Notifying thread to start radio shutdown"

    invoke-static {v3, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 135
    if-eqz p1, :cond_73

    .line 136
    new-instance v1, Landroid/app/AlertDialog$Builder;

    invoke-direct {v1, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    const v2, 0x1080027

    invoke-virtual {v1, v2}, Landroid/app/AlertDialog$Builder;->setIcon(I)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    const v2, 0x1040127

    invoke-virtual {v1, v2}, Landroid/app/AlertDialog$Builder;->setTitle(I)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    const v2, 0x1040129

    invoke-virtual {v1, v2}, Landroid/app/AlertDialog$Builder;->setMessage(I)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    const v2, 0x1040013

    new-instance v3, Lcom/android/internal/app/ShutdownThread$1;

    invoke-direct {v3, p0}, Lcom/android/internal/app/ShutdownThread$1;-><init>(Landroid/content/Context;)V

    invoke-virtual {v1, v2, v3}, Landroid/app/AlertDialog$Builder;->setPositiveButton(ILandroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    const v2, 0x1040009

    const/4 v3, 0x0

    invoke-virtual {v1, v2, v3}, Landroid/app/AlertDialog$Builder;->setNegativeButton(ILandroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    invoke-virtual {v1}, Landroid/app/AlertDialog$Builder;->create()Landroid/app/AlertDialog;

    move-result-object v0

    .line 147
    .local v0, dialog:Landroid/app/AlertDialog;
    invoke-virtual {v0}, Landroid/app/AlertDialog;->getWindow()Landroid/view/Window;

    move-result-object v1

    const/16 v2, 0x7d9

    invoke-virtual {v1, v2}, Landroid/view/Window;->setType(I)V

    .line 148
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    const v2, 0x10d0001

    invoke-virtual {v1, v2}, Landroid/content/res/Resources;->getBoolean(I)Z

    move-result v1

    if-nez v1, :cond_6c

    .line 150
    invoke-virtual {v0}, Landroid/app/AlertDialog;->getWindow()Landroid/view/Window;

    move-result-object v1

    const/4 v2, 0x4

    invoke-virtual {v1, v2}, Landroid/view/Window;->addFlags(I)V

    .line 152
    :cond_6c
    invoke-virtual {v0}, Landroid/app/AlertDialog;->show()V

    goto :goto_11

    .line 131
    .end local v0           #dialog:Landroid/app/AlertDialog;
    :catchall_70
    move-exception v2

    :try_start_71
    monitor-exit v1
    :try_end_72
    .catchall {:try_start_71 .. :try_end_72} :catchall_70

    throw v2

    .line 154
    :cond_73
    invoke-static {p0}, Lcom/android/internal/app/ShutdownThread;->beginShutdownSequence(Landroid/content/Context;)V

    goto :goto_11
.end method

.method public static systemReady()V
    .registers 2

    .prologue
    .line 520
    sget-object v0, Lcom/android/internal/app/ShutdownThread;->sSystemReadySync:Ljava/lang/Object;

    monitor-enter v0

    .line 521
    const/4 v1, 0x1

    :try_start_4
    sput-boolean v1, Lcom/android/internal/app/ShutdownThread;->sSystemReady:Z

    .line 522
    monitor-exit v0

    .line 523
    return-void

    .line 522
    :catchall_8
    move-exception v1

    monitor-exit v0
    :try_end_a
    .catchall {:try_start_4 .. :try_end_a} :catchall_8

    throw v1
.end method


# virtual methods
.method actionDone()V
    .registers 3

    .prologue
    .line 223
    iget-object v0, p0, Lcom/android/internal/app/ShutdownThread;->mActionDoneSync:Ljava/lang/Object;

    monitor-enter v0

    .line 224
    const/4 v1, 0x1

    :try_start_4
    iput-boolean v1, p0, Lcom/android/internal/app/ShutdownThread;->mActionDone:Z

    .line 225
    iget-object v1, p0, Lcom/android/internal/app/ShutdownThread;->mActionDoneSync:Ljava/lang/Object;

    invoke-virtual {v1}, Ljava/lang/Object;->notifyAll()V

    .line 226
    monitor-exit v0

    .line 227
    return-void

    .line 226
    :catchall_d
    move-exception v1

    monitor-exit v0
    :try_end_f
    .catchall {:try_start_4 .. :try_end_f} :catchall_d

    throw v1
.end method

.method public run()V
    .registers 32

    .prologue
    .line 258
    sget-boolean v4, Lcom/android/internal/app/ShutdownThread;->DEBUG_KPI:Z

    if-eqz v4, :cond_b

    const-string v4, "KPI-SHUTDOWN-2"

    const-string v5, "ShutdownThread.run start"

    invoke-static {v4, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 262
    :cond_b
    sget-object v29, Lcom/android/internal/app/ShutdownThread;->sSystemReadySync:Ljava/lang/Object;

    monitor-enter v29

    .line 264
    :try_start_e
    sget-boolean v4, Lcom/android/internal/app/ShutdownThread;->sSystemReady:Z

    if-eqz v4, :cond_19b

    .line 267
    new-instance v7, Lcom/android/internal/app/ShutdownThread$4;

    move-object v0, v7

    move-object/from16 v1, p0

    invoke-direct {v0, v1}, Lcom/android/internal/app/ShutdownThread$4;-><init>(Lcom/android/internal/app/ShutdownThread;)V

    .line 275
    .local v7, br:Landroid/content/BroadcastReceiver;
    sget-boolean v4, Lcom/android/internal/app/ShutdownThread;->DEBUG_KPI:Z

    if-eqz v4, :cond_1c2

    .line 276
    const-string v4, "KPI-SHUTDOWN-3"

    const-string v5, "Sending shutdown broadcast..."

    invoke-static {v4, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 288
    :goto_25
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    sget-boolean v5, Lcom/android/internal/app/ShutdownThread;->mReboot:Z

    if-eqz v5, :cond_1ce

    const-string v5, "1"

    :goto_30
    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    sget-object v5, Lcom/android/internal/app/ShutdownThread;->mRebootReason:Ljava/lang/String;

    if-eqz v5, :cond_1d2

    sget-object v5, Lcom/android/internal/app/ShutdownThread;->mRebootReason:Ljava/lang/String;

    :goto_3a
    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v28

    .line 289
    .local v28, reason:Ljava/lang/String;
    const-string/jumbo v4, "sys.shutdown.requested"

    move-object v0, v4

    move-object/from16 v1, v28

    invoke-static {v0, v1}, Landroid/os/SystemProperties;->set(Ljava/lang/String;Ljava/lang/String;)V

    .line 292
    const-string v4, "ShutdownThread"

    const-string v5, "Sending shutdown broadcast..."

    invoke-static {v4, v5}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 295
    const/4 v4, 0x0

    move v0, v4

    move-object/from16 v1, p0

    iput-boolean v0, v1, Lcom/android/internal/app/ShutdownThread;->mActionDone:Z

    .line 296
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/app/ShutdownThread;->mContext:Landroid/content/Context;

    move-object v4, v0

    new-instance v5, Landroid/content/Intent;

    const-string v6, "android.intent.action.ACTION_SHUTDOWN"

    invoke-direct {v5, v6}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    const/4 v6, 0x0

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/app/ShutdownThread;->mHandler:Landroid/os/Handler;

    move-object v8, v0

    const/4 v9, 0x0

    const/4 v10, 0x0

    const/4 v11, 0x0

    invoke-virtual/range {v4 .. v11}, Landroid/content/Context;->sendOrderedBroadcast(Landroid/content/Intent;Ljava/lang/String;Landroid/content/BroadcastReceiver;Landroid/os/Handler;ILjava/lang/String;Landroid/os/Bundle;)V

    .line 299
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v4

    const-wide/16 v6, 0x2710

    add-long v20, v4, v6

    .line 300
    .local v20, endTime:J
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/app/ShutdownThread;->mActionDoneSync:Ljava/lang/Object;

    move-object v4, v0

    monitor-enter v4
    :try_end_7e
    .catchall {:try_start_e .. :try_end_7e} :catchall_1cb

    .line 301
    :goto_7e
    :try_start_7e
    move-object/from16 v0, p0

    iget-boolean v0, v0, Lcom/android/internal/app/ShutdownThread;->mActionDone:Z

    move v5, v0

    if-nez v5, :cond_98

    .line 302
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v5

    sub-long v15, v20, v5

    .line 303
    .local v15, delay:J
    const-wide/16 v5, 0x0

    cmp-long v5, v15, v5

    if-gtz v5, :cond_1d6

    .line 304
    const-string v5, "ShutdownThread"

    const-string v6, "Shutdown broadcast timed out"

    invoke-static {v5, v6}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 312
    .end local v15           #delay:J
    :cond_98
    monitor-exit v4
    :try_end_99
    .catchall {:try_start_7e .. :try_end_99} :catchall_1e5

    .line 314
    :try_start_99
    const-string v4, "ShutdownThread"

    const-string v5, "Shutting down activity manager..."

    invoke-static {v4, v5}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 318
    sget-boolean v4, Lcom/android/internal/app/ShutdownThread;->DEBUG_KPI:Z

    if-eqz v4, :cond_1e8

    .line 319
    const-string v4, "KPI-SHUTDOWN-4"

    const-string v5, "Shutting down activity manager..."

    invoke-static {v4, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 324
    :goto_ab
    const-string v4, "activity"

    invoke-static {v4}, Landroid/os/ServiceManager;->checkService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v4

    invoke-static {v4}, Landroid/app/ActivityManagerNative;->asInterface(Landroid/os/IBinder;)Landroid/app/IActivityManager;
    :try_end_b4
    .catchall {:try_start_99 .. :try_end_b4} :catchall_1cb

    move-result-object v12

    .line 326
    .local v12, am:Landroid/app/IActivityManager;
    if-eqz v12, :cond_bc

    .line 328
    const/16 v4, 0x2710

    :try_start_b9
    invoke-interface {v12, v4}, Landroid/app/IActivityManager;->shutdown(I)Z
    :try_end_bc
    .catchall {:try_start_b9 .. :try_end_bc} :catchall_1cb
    .catch Landroid/os/RemoteException; {:try_start_b9 .. :try_end_bc} :catch_288

    .line 334
    :cond_bc
    :goto_bc
    :try_start_bc
    sget-boolean v4, Lcom/android/internal/app/ShutdownThread;->DEBUG_KPI:Z

    if-eqz v4, :cond_c7

    .line 335
    const-string v4, "KPI-SHUTDOWN-5"

    const-string v5, "Shutting down BT and Radio..."

    invoke-static {v4, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 339
    :cond_c7
    const-string/jumbo v4, "phone"

    invoke-static {v4}, Landroid/os/ServiceManager;->checkService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v4

    invoke-static {v4}, Lcom/android/internal/telephony/ITelephony$Stub;->asInterface(Landroid/os/IBinder;)Lcom/android/internal/telephony/ITelephony;

    move-result-object v26

    .line 341
    .local v26, phone:Lcom/android/internal/telephony/ITelephony;
    const-string v4, "bluetooth"

    invoke-static {v4}, Landroid/os/ServiceManager;->checkService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v4

    invoke-static {v4}, Landroid/bluetooth/IBluetooth$Stub;->asInterface(Landroid/os/IBinder;)Landroid/bluetooth/IBluetooth;

    move-result-object v13

    .line 345
    .local v13, bluetooth:Landroid/bluetooth/IBluetooth;
    const-string v4, "mount"

    invoke-static {v4}, Landroid/os/ServiceManager;->checkService(Ljava/lang/String;)Landroid/os/IBinder;

    move-result-object v4

    invoke-static {v4}, Landroid/os/storage/IMountService$Stub;->asInterface(Landroid/os/IBinder;)Landroid/os/storage/IMountService;
    :try_end_e5
    .catchall {:try_start_bc .. :try_end_e5} :catchall_1cb

    move-result-object v24

    .line 350
    .local v24, mount:Landroid/os/storage/IMountService;
    if-eqz v13, :cond_f0

    :try_start_e8
    invoke-interface {v13}, Landroid/bluetooth/IBluetooth;->getBluetoothState()I

    move-result v4

    const/16 v5, 0xa

    if-ne v4, v5, :cond_1f1

    :cond_f0
    const/4 v4, 0x1

    move v14, v4

    .line 352
    .local v14, bluetoothOff:Z
    :goto_f2
    if-nez v14, :cond_ff

    .line 353
    const-string v4, "ShutdownThread"

    const-string v5, "Disabling Bluetooth..."

    invoke-static {v4, v5}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 354
    const/4 v4, 0x0

    invoke-interface {v13, v4}, Landroid/bluetooth/IBluetooth;->disable(Z)Z
    :try_end_ff
    .catchall {:try_start_e8 .. :try_end_ff} :catchall_1cb
    .catch Landroid/os/RemoteException; {:try_start_e8 .. :try_end_ff} :catch_1f5

    .line 362
    :cond_ff
    :goto_ff
    if-eqz v26, :cond_107

    :try_start_101
    invoke-interface/range {v26 .. v26}, Lcom/android/internal/telephony/ITelephony;->isRadioOn()Z

    move-result v4

    if-nez v4, :cond_206

    :cond_107
    const/4 v4, 0x1

    move/from16 v27, v4

    .line 363
    .local v27, radioOff:Z
    :goto_10a
    if-nez v27, :cond_11a

    .line 364
    const-string v4, "ShutdownThread"

    const-string v5, "Turning off radio..."

    invoke-static {v4, v5}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 365
    const/4 v4, 0x0

    move-object/from16 v0, v26

    move v1, v4

    invoke-interface {v0, v1}, Lcom/android/internal/telephony/ITelephony;->setRadio(Z)Z
    :try_end_11a
    .catchall {:try_start_101 .. :try_end_11a} :catchall_1cb
    .catch Landroid/os/RemoteException; {:try_start_101 .. :try_end_11a} :catch_20b

    .line 372
    :cond_11a
    :goto_11a
    :try_start_11a
    const-string v4, "ShutdownThread"

    const-string v5, "Waiting for Bluetooth and Radio..."

    invoke-static {v4, v5}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_121
    .catchall {:try_start_11a .. :try_end_121} :catchall_1cb

    .line 375
    const/16 v23, 0x0

    .local v23, i:I
    :goto_123
    const/16 v4, 0x10

    move/from16 v0, v23

    move v1, v4

    if-ge v0, v1, :cond_14c

    .line 376
    if-nez v14, :cond_136

    .line 378
    :try_start_12c
    invoke-interface {v13}, Landroid/bluetooth/IBluetooth;->getBluetoothState()I
    :try_end_12f
    .catchall {:try_start_12c .. :try_end_12f} :catchall_1cb
    .catch Landroid/os/RemoteException; {:try_start_12c .. :try_end_12f} :catch_221

    move-result v4

    const/16 v5, 0xa

    if-ne v4, v5, :cond_21d

    const/4 v4, 0x1

    move v14, v4

    .line 385
    :cond_136
    :goto_136
    if-nez v27, :cond_141

    .line 387
    :try_start_138
    invoke-interface/range {v26 .. v26}, Lcom/android/internal/telephony/ITelephony;->isRadioOn()Z
    :try_end_13b
    .catchall {:try_start_138 .. :try_end_13b} :catchall_1cb
    .catch Landroid/os/RemoteException; {:try_start_138 .. :try_end_13b} :catch_235

    move-result v4

    if-nez v4, :cond_230

    const/4 v4, 0x1

    move/from16 v27, v4

    .line 393
    :cond_141
    :goto_141
    if-eqz v27, :cond_245

    if-eqz v14, :cond_245

    .line 394
    :try_start_145
    const-string v4, "ShutdownThread"

    const-string v5, "Radio and Bluetooth shutdown complete."

    invoke-static {v4, v5}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 410
    :cond_14c
    sget-boolean v4, Lcom/android/internal/app/ShutdownThread;->DEBUG_KPI:Z

    if-eqz v4, :cond_157

    .line 411
    const-string v4, "KPI-SHUTDOWN-6"

    const-string v5, "Shutting down mount service..."

    invoke-static {v4, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 415
    :cond_157
    new-instance v25, Lcom/android/internal/app/ShutdownThread$5;

    move-object/from16 v0, v25

    move-object/from16 v1, p0

    invoke-direct {v0, v1}, Lcom/android/internal/app/ShutdownThread$5;-><init>(Lcom/android/internal/app/ShutdownThread;)V

    .line 422
    .local v25, observer:Landroid/os/storage/IMountShutdownObserver;
    const-string v4, "ShutdownThread"

    const-string v5, "Shutting down MountService"

    invoke-static {v4, v5}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 424
    const/4 v4, 0x0

    move v0, v4

    move-object/from16 v1, p0

    iput-boolean v0, v1, Lcom/android/internal/app/ShutdownThread;->mActionDone:Z

    .line 425
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v4

    const-wide/16 v6, 0x4e20

    add-long v18, v4, v6

    .line 426
    .local v18, endShutTime:J
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/app/ShutdownThread;->mActionDoneSync:Ljava/lang/Object;

    move-object v4, v0

    monitor-enter v4
    :try_end_17b
    .catchall {:try_start_145 .. :try_end_17b} :catchall_1cb

    .line 428
    if-eqz v24, :cond_25d

    .line 429
    :try_start_17d
    invoke-interface/range {v24 .. v25}, Landroid/os/storage/IMountService;->shutdown(Landroid/os/storage/IMountShutdownObserver;)V
    :try_end_180
    .catchall {:try_start_17d .. :try_end_180} :catchall_276
    .catch Ljava/lang/Exception; {:try_start_17d .. :try_end_180} :catch_266

    .line 436
    :goto_180
    :try_start_180
    move-object/from16 v0, p0

    iget-boolean v0, v0, Lcom/android/internal/app/ShutdownThread;->mActionDone:Z

    move v5, v0

    if-nez v5, :cond_19a

    .line 437
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v5

    sub-long v15, v18, v5

    .line 438
    .restart local v15       #delay:J
    const-wide/16 v5, 0x0

    cmp-long v5, v15, v5

    if-gtz v5, :cond_279

    .line 439
    const-string v5, "ShutdownThread"

    const-string v6, "Shutdown wait timed out"

    invoke-static {v5, v6}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 447
    .end local v15           #delay:J
    :cond_19a
    monitor-exit v4
    :try_end_19b
    .catchall {:try_start_180 .. :try_end_19b} :catchall_276

    .line 452
    .end local v7           #br:Landroid/content/BroadcastReceiver;
    .end local v12           #am:Landroid/app/IActivityManager;
    .end local v13           #bluetooth:Landroid/bluetooth/IBluetooth;
    .end local v14           #bluetoothOff:Z
    .end local v18           #endShutTime:J
    .end local v20           #endTime:J
    .end local v23           #i:I
    .end local v24           #mount:Landroid/os/storage/IMountService;
    .end local v25           #observer:Landroid/os/storage/IMountShutdownObserver;
    .end local v26           #phone:Lcom/android/internal/telephony/ITelephony;
    .end local v27           #radioOff:Z
    .end local v28           #reason:Ljava/lang/String;
    :cond_19b
    :try_start_19b
    monitor-exit v29
    :try_end_19c
    .catchall {:try_start_19b .. :try_end_19c} :catchall_1cb

    .line 454
    sget-boolean v4, Lcom/android/internal/app/ShutdownThread;->mReboot:Z

    if-nez v4, :cond_1ba

    .line 456
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    sget-wide v6, Lcom/android/internal/app/ShutdownThread;->mStartShutdownTime:J

    sub-long v29, v4, v6

    .line 457
    .local v29, timeTaken:J
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/app/ShutdownThread;->mContext:Landroid/content/Context;

    move-object v4, v0

    invoke-virtual {v4}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v4

    const-string v5, "TimeToPowerDown"

    move-object v0, v4

    move-object v1, v5

    move-wide/from16 v2, v29

    invoke-static {v0, v1, v2, v3}, Landroid/provider/Settings$System;->putLong(Landroid/content/ContentResolver;Ljava/lang/String;J)Z

    .line 461
    .end local v29           #timeTaken:J
    :cond_1ba
    sget-boolean v4, Lcom/android/internal/app/ShutdownThread;->mReboot:Z

    sget-object v5, Lcom/android/internal/app/ShutdownThread;->mRebootReason:Ljava/lang/String;

    invoke-static {v4, v5}, Lcom/android/internal/app/ShutdownThread;->rebootOrShutdown(ZLjava/lang/String;)V

    .line 462
    return-void

    .line 278
    .restart local v7       #br:Landroid/content/BroadcastReceiver;
    :cond_1c2
    :try_start_1c2
    const-string v4, "ShutdownThread"

    const-string v5, "Sending shutdown broadcast..."

    invoke-static {v4, v5}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_25

    .line 452
    .end local v7           #br:Landroid/content/BroadcastReceiver;
    :catchall_1cb
    move-exception v4

    monitor-exit v29
    :try_end_1cd
    .catchall {:try_start_1c2 .. :try_end_1cd} :catchall_1cb

    throw v4

    .line 288
    .restart local v7       #br:Landroid/content/BroadcastReceiver;
    :cond_1ce
    :try_start_1ce
    const-string v5, "0"

    goto/16 :goto_30

    :cond_1d2
    const-string v5, ""
    :try_end_1d4
    .catchall {:try_start_1ce .. :try_end_1d4} :catchall_1cb

    goto/16 :goto_3a

    .line 308
    .restart local v15       #delay:J
    .restart local v20       #endTime:J
    .restart local v28       #reason:Ljava/lang/String;
    :cond_1d6
    :try_start_1d6
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/app/ShutdownThread;->mActionDoneSync:Ljava/lang/Object;

    move-object v5, v0

    move-object v0, v5

    move-wide v1, v15

    invoke-virtual {v0, v1, v2}, Ljava/lang/Object;->wait(J)V
    :try_end_1e0
    .catchall {:try_start_1d6 .. :try_end_1e0} :catchall_1e5
    .catch Ljava/lang/InterruptedException; {:try_start_1d6 .. :try_end_1e0} :catch_1e2

    goto/16 :goto_7e

    .line 309
    :catch_1e2
    move-exception v5

    goto/16 :goto_7e

    .line 312
    .end local v15           #delay:J
    :catchall_1e5
    move-exception v5

    :try_start_1e6
    monitor-exit v4
    :try_end_1e7
    .catchall {:try_start_1e6 .. :try_end_1e7} :catchall_1e5

    :try_start_1e7
    throw v5

    .line 321
    :cond_1e8
    const-string v4, "ShutdownThread"

    const-string v5, "Shutting down activity manager..."

    invoke-static {v4, v5}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_ab

    .line 350
    .restart local v12       #am:Landroid/app/IActivityManager;
    .restart local v13       #bluetooth:Landroid/bluetooth/IBluetooth;
    .restart local v24       #mount:Landroid/os/storage/IMountService;
    .restart local v26       #phone:Lcom/android/internal/telephony/ITelephony;
    :cond_1f1
    const/4 v4, 0x0

    move v14, v4

    goto/16 :goto_f2

    .line 356
    :catch_1f5
    move-exception v4

    move-object/from16 v22, v4

    .line 357
    .local v22, ex:Landroid/os/RemoteException;
    const-string v4, "ShutdownThread"

    const-string v5, "RemoteException during bluetooth shutdown"

    move-object v0, v4

    move-object v1, v5

    move-object/from16 v2, v22

    invoke-static {v0, v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 358
    const/4 v14, 0x1

    .restart local v14       #bluetoothOff:Z
    goto/16 :goto_ff

    .line 362
    .end local v22           #ex:Landroid/os/RemoteException;
    :cond_206
    const/4 v4, 0x0

    move/from16 v27, v4

    goto/16 :goto_10a

    .line 367
    :catch_20b
    move-exception v4

    move-object/from16 v22, v4

    .line 368
    .restart local v22       #ex:Landroid/os/RemoteException;
    const-string v4, "ShutdownThread"

    const-string v5, "RemoteException during radio shutdown"

    move-object v0, v4

    move-object v1, v5

    move-object/from16 v2, v22

    invoke-static {v0, v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 369
    const/16 v27, 0x1

    .restart local v27       #radioOff:Z
    goto/16 :goto_11a

    .line 378
    .end local v22           #ex:Landroid/os/RemoteException;
    .restart local v23       #i:I
    :cond_21d
    const/4 v4, 0x0

    move v14, v4

    goto/16 :goto_136

    .line 380
    :catch_221
    move-exception v22

    .line 381
    .restart local v22       #ex:Landroid/os/RemoteException;
    const-string v4, "ShutdownThread"

    const-string v5, "RemoteException during bluetooth shutdown"

    move-object v0, v4

    move-object v1, v5

    move-object/from16 v2, v22

    invoke-static {v0, v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 382
    const/4 v14, 0x1

    goto/16 :goto_136

    .line 387
    .end local v22           #ex:Landroid/os/RemoteException;
    :cond_230
    const/4 v4, 0x0

    move/from16 v27, v4

    goto/16 :goto_141

    .line 388
    :catch_235
    move-exception v22

    .line 389
    .restart local v22       #ex:Landroid/os/RemoteException;
    const-string v4, "ShutdownThread"

    const-string v5, "RemoteException during radio shutdown"

    move-object v0, v4

    move-object v1, v5

    move-object/from16 v2, v22

    invoke-static {v0, v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 390
    const/16 v27, 0x1

    goto/16 :goto_141

    .line 399
    .end local v22           #ex:Landroid/os/RemoteException;
    :cond_245
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/app/ShutdownThread;->mRadioOffSync:Ljava/lang/Object;

    move-object v4, v0

    monitor-enter v4
    :try_end_24b
    .catchall {:try_start_1e7 .. :try_end_24b} :catchall_1cb

    .line 401
    :try_start_24b
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/app/ShutdownThread;->mRadioOffSync:Ljava/lang/Object;

    move-object v5, v0

    const-wide/16 v6, 0x1f4

    invoke-virtual {v5, v6, v7}, Ljava/lang/Object;->wait(J)V
    :try_end_255
    .catchall {:try_start_24b .. :try_end_255} :catchall_25a
    .catch Ljava/lang/InterruptedException; {:try_start_24b .. :try_end_255} :catch_28b

    .line 404
    :goto_255
    :try_start_255
    monitor-exit v4

    .line 375
    add-int/lit8 v23, v23, 0x1

    goto/16 :goto_123

    .line 404
    :catchall_25a
    move-exception v5

    monitor-exit v4
    :try_end_25c
    .catchall {:try_start_255 .. :try_end_25c} :catchall_25a

    :try_start_25c
    throw v5
    :try_end_25d
    .catchall {:try_start_25c .. :try_end_25d} :catchall_1cb

    .line 431
    .restart local v18       #endShutTime:J
    .restart local v25       #observer:Landroid/os/storage/IMountShutdownObserver;
    :cond_25d
    :try_start_25d
    const-string v5, "ShutdownThread"

    const-string v6, "MountService unavailable for shutdown"

    invoke-static {v5, v6}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_264
    .catchall {:try_start_25d .. :try_end_264} :catchall_276
    .catch Ljava/lang/Exception; {:try_start_25d .. :try_end_264} :catch_266

    goto/16 :goto_180

    .line 433
    :catch_266
    move-exception v5

    move-object/from16 v17, v5

    .line 434
    .local v17, e:Ljava/lang/Exception;
    :try_start_269
    const-string v5, "ShutdownThread"

    const-string v6, "Exception during MountService shutdown"

    move-object v0, v5

    move-object v1, v6

    move-object/from16 v2, v17

    invoke-static {v0, v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto/16 :goto_180

    .line 447
    .end local v17           #e:Ljava/lang/Exception;
    :catchall_276
    move-exception v5

    monitor-exit v4
    :try_end_278
    .catchall {:try_start_269 .. :try_end_278} :catchall_276

    :try_start_278
    throw v5
    :try_end_279
    .catchall {:try_start_278 .. :try_end_279} :catchall_1cb

    .line 443
    .restart local v15       #delay:J
    :cond_279
    :try_start_279
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/android/internal/app/ShutdownThread;->mActionDoneSync:Ljava/lang/Object;

    move-object v5, v0

    move-object v0, v5

    move-wide v1, v15

    invoke-virtual {v0, v1, v2}, Ljava/lang/Object;->wait(J)V
    :try_end_283
    .catchall {:try_start_279 .. :try_end_283} :catchall_276
    .catch Ljava/lang/InterruptedException; {:try_start_279 .. :try_end_283} :catch_285

    goto/16 :goto_180

    .line 444
    :catch_285
    move-exception v5

    goto/16 :goto_180

    .line 329
    .end local v13           #bluetooth:Landroid/bluetooth/IBluetooth;
    .end local v14           #bluetoothOff:Z
    .end local v15           #delay:J
    .end local v18           #endShutTime:J
    .end local v23           #i:I
    .end local v24           #mount:Landroid/os/storage/IMountService;
    .end local v25           #observer:Landroid/os/storage/IMountShutdownObserver;
    .end local v26           #phone:Lcom/android/internal/telephony/ITelephony;
    .end local v27           #radioOff:Z
    :catch_288
    move-exception v4

    goto/16 :goto_bc

    .line 402
    .restart local v13       #bluetooth:Landroid/bluetooth/IBluetooth;
    .restart local v14       #bluetoothOff:Z
    .restart local v23       #i:I
    .restart local v24       #mount:Landroid/os/storage/IMountService;
    .restart local v26       #phone:Lcom/android/internal/telephony/ITelephony;
    .restart local v27       #radioOff:Z
    :catch_28b
    move-exception v5

    goto :goto_255
.end method
