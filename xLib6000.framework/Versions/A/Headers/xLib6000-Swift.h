// Generated by Apple Swift version 4.2.1 (swiftlang-1000.11.42 clang-1000.11.45.1)
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgcc-compat"

#if !defined(__has_include)
# define __has_include(x) 0
#endif
#if !defined(__has_attribute)
# define __has_attribute(x) 0
#endif
#if !defined(__has_feature)
# define __has_feature(x) 0
#endif
#if !defined(__has_warning)
# define __has_warning(x) 0
#endif

#if __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wauto-import"
#include <objc/NSObject.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#if !defined(SWIFT_TYPEDEFS)
# define SWIFT_TYPEDEFS 1
# if __has_include(<uchar.h>)
#  include <uchar.h>
# elif !defined(__cplusplus)
typedef uint_least16_t char16_t;
typedef uint_least32_t char32_t;
# endif
typedef float swift_float2  __attribute__((__ext_vector_type__(2)));
typedef float swift_float3  __attribute__((__ext_vector_type__(3)));
typedef float swift_float4  __attribute__((__ext_vector_type__(4)));
typedef double swift_double2  __attribute__((__ext_vector_type__(2)));
typedef double swift_double3  __attribute__((__ext_vector_type__(3)));
typedef double swift_double4  __attribute__((__ext_vector_type__(4)));
typedef int swift_int2  __attribute__((__ext_vector_type__(2)));
typedef int swift_int3  __attribute__((__ext_vector_type__(3)));
typedef int swift_int4  __attribute__((__ext_vector_type__(4)));
typedef unsigned int swift_uint2  __attribute__((__ext_vector_type__(2)));
typedef unsigned int swift_uint3  __attribute__((__ext_vector_type__(3)));
typedef unsigned int swift_uint4  __attribute__((__ext_vector_type__(4)));
#endif

#if !defined(SWIFT_PASTE)
# define SWIFT_PASTE_HELPER(x, y) x##y
# define SWIFT_PASTE(x, y) SWIFT_PASTE_HELPER(x, y)
#endif
#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
#endif
#if !defined(SWIFT_CLASS_PROPERTY)
# if __has_feature(objc_class_property)
#  define SWIFT_CLASS_PROPERTY(...) __VA_ARGS__
# else
#  define SWIFT_CLASS_PROPERTY(...)
# endif
#endif

#if __has_attribute(objc_runtime_name)
# define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
#else
# define SWIFT_RUNTIME_NAME(X)
#endif
#if __has_attribute(swift_name)
# define SWIFT_COMPILE_NAME(X) __attribute__((swift_name(X)))
#else
# define SWIFT_COMPILE_NAME(X)
#endif
#if __has_attribute(objc_method_family)
# define SWIFT_METHOD_FAMILY(X) __attribute__((objc_method_family(X)))
#else
# define SWIFT_METHOD_FAMILY(X)
#endif
#if __has_attribute(noescape)
# define SWIFT_NOESCAPE __attribute__((noescape))
#else
# define SWIFT_NOESCAPE
#endif
#if __has_attribute(warn_unused_result)
# define SWIFT_WARN_UNUSED_RESULT __attribute__((warn_unused_result))
#else
# define SWIFT_WARN_UNUSED_RESULT
#endif
#if __has_attribute(noreturn)
# define SWIFT_NORETURN __attribute__((noreturn))
#else
# define SWIFT_NORETURN
#endif
#if !defined(SWIFT_CLASS_EXTRA)
# define SWIFT_CLASS_EXTRA
#endif
#if !defined(SWIFT_PROTOCOL_EXTRA)
# define SWIFT_PROTOCOL_EXTRA
#endif
#if !defined(SWIFT_ENUM_EXTRA)
# define SWIFT_ENUM_EXTRA
#endif
#if !defined(SWIFT_CLASS)
# if __has_attribute(objc_subclassing_restricted)
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# else
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# endif
#endif

#if !defined(SWIFT_PROTOCOL)
# define SWIFT_PROTOCOL(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
# define SWIFT_PROTOCOL_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
#endif

#if !defined(SWIFT_EXTENSION)
# define SWIFT_EXTENSION(M) SWIFT_PASTE(M##_Swift_, __LINE__)
#endif

#if !defined(OBJC_DESIGNATED_INITIALIZER)
# if __has_attribute(objc_designated_initializer)
#  define OBJC_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
# else
#  define OBJC_DESIGNATED_INITIALIZER
# endif
#endif
#if !defined(SWIFT_ENUM_ATTR)
# if defined(__has_attribute) && __has_attribute(enum_extensibility)
#  define SWIFT_ENUM_ATTR(_extensibility) __attribute__((enum_extensibility(_extensibility)))
# else
#  define SWIFT_ENUM_ATTR(_extensibility)
# endif
#endif
#if !defined(SWIFT_ENUM)
# define SWIFT_ENUM(_type, _name, _extensibility) enum _name : _type _name; enum SWIFT_ENUM_ATTR(_extensibility) SWIFT_ENUM_EXTRA _name : _type
# if __has_feature(generalized_swift_name)
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME, _extensibility) enum _name : _type _name SWIFT_COMPILE_NAME(SWIFT_NAME); enum SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_ENUM_ATTR(_extensibility) SWIFT_ENUM_EXTRA _name : _type
# else
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME, _extensibility) SWIFT_ENUM(_type, _name, _extensibility)
# endif
#endif
#if !defined(SWIFT_UNAVAILABLE)
# define SWIFT_UNAVAILABLE __attribute__((unavailable))
#endif
#if !defined(SWIFT_UNAVAILABLE_MSG)
# define SWIFT_UNAVAILABLE_MSG(msg) __attribute__((unavailable(msg)))
#endif
#if !defined(SWIFT_AVAILABILITY)
# define SWIFT_AVAILABILITY(plat, ...) __attribute__((availability(plat, __VA_ARGS__)))
#endif
#if !defined(SWIFT_DEPRECATED)
# define SWIFT_DEPRECATED __attribute__((deprecated))
#endif
#if !defined(SWIFT_DEPRECATED_MSG)
# define SWIFT_DEPRECATED_MSG(...) __attribute__((deprecated(__VA_ARGS__)))
#endif
#if __has_feature(attribute_diagnose_if_objc)
# define SWIFT_DEPRECATED_OBJC(Msg) __attribute__((diagnose_if(1, Msg, "warning")))
#else
# define SWIFT_DEPRECATED_OBJC(Msg) SWIFT_DEPRECATED_MSG(Msg)
#endif
#if __has_feature(modules)
@import CoreGraphics;
@import Foundation;
@import ObjectiveC;
#endif

#import <xLib6000/xLib6000.h>

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"
#if __has_warning("-Wpragma-clang-attribute")
# pragma clang diagnostic ignored "-Wpragma-clang-attribute"
#endif
#pragma clang diagnostic ignored "-Wunknown-pragmas"
#pragma clang diagnostic ignored "-Wnullability"

#if __has_attribute(external_source_symbol)
# pragma push_macro("any")
# undef any
# pragma clang attribute push(__attribute__((external_source_symbol(language="Swift", defined_in="xLib6000",generated_declaration))), apply_to=any(function,enum,objc_interface,objc_category,objc_protocol))
# pragma pop_macro("any")
#endif


SWIFT_CLASS("_TtC8xLib60009Amplifier")
@interface Amplifier : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_DEPRECATED_MSG("-init is unavailable");
@end




@interface Amplifier (SWIFT_EXTENSION(xLib6000))
@property (nonatomic, copy) NSString * _Nonnull ant;
@property (nonatomic, copy) NSString * _Nonnull ip;
@property (nonatomic, copy) NSString * _Nonnull model;
@property (nonatomic, copy) NSString * _Nonnull mode;
@property (nonatomic) NSInteger port;
@property (nonatomic, copy) NSString * _Nonnull serialNumber;
@end

@class Radio;

SWIFT_CLASS("_TtC8xLib60003Api")
@interface Api : NSObject
@property (nonatomic, strong) Radio * _Nullable radio;
/// Provide access to the API singleton
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, strong) Api * _Nonnull sharedInstance;)
+ (Api * _Nonnull)sharedInstance SWIFT_WARN_UNUSED_RESULT;
+ (void)setSharedInstance:(Api * _Nonnull)value;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_DEPRECATED_MSG("-init is unavailable");
@end




SWIFT_CLASS("_TtC8xLib60003Atu")
@interface Atu : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_DEPRECATED_MSG("-init is unavailable");
@end


@interface Atu (SWIFT_EXTENSION(xLib6000))
@property (nonatomic) BOOL memoriesEnabled;
@property (nonatomic, readonly) BOOL enabled;
@end


@interface Atu (SWIFT_EXTENSION(xLib6000))
@property (nonatomic, readonly, copy) NSString * _Nonnull status;
@property (nonatomic, readonly) BOOL usingMemories;
@end


SWIFT_CLASS("_TtC8xLib600011AudioStream")
@interface AudioStream : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_DEPRECATED_MSG("-init is unavailable");
@end


@interface AudioStream (SWIFT_EXTENSION(xLib6000))
@property (nonatomic) NSInteger rxGain;
@end

@class Slice;

@interface AudioStream (SWIFT_EXTENSION(xLib6000))
@property (nonatomic) NSInteger daxChannel;
@property (nonatomic) NSInteger daxClients;
@property (nonatomic, readonly) BOOL inUse;
@property (nonatomic, copy) NSString * _Nonnull ip;
@property (nonatomic) NSInteger port;
@property (nonatomic, strong) Slice * _Nullable slice;
@end


SWIFT_CLASS("_TtC8xLib60003Cwx")
@interface Cwx : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_DEPRECATED_MSG("-init is unavailable");
@end




@interface Cwx (SWIFT_EXTENSION(xLib6000))
@property (nonatomic) NSInteger breakInDelay;
@property (nonatomic) BOOL qskEnabled;
@property (nonatomic) NSInteger wpm;
@end


SWIFT_CLASS("_TtC8xLib60009Equalizer")
@interface Equalizer : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_DEPRECATED_MSG("-init is unavailable");
@end




@interface Equalizer (SWIFT_EXTENSION(xLib6000))
@property (nonatomic) BOOL eqEnabled;
@property (nonatomic) NSInteger level63Hz;
@property (nonatomic) NSInteger level125Hz;
@property (nonatomic) NSInteger level250Hz;
@property (nonatomic) NSInteger level500Hz;
@property (nonatomic) NSInteger level1000Hz;
@property (nonatomic) NSInteger level2000Hz;
@property (nonatomic) NSInteger level4000Hz;
@property (nonatomic) NSInteger level8000Hz;
@end


SWIFT_CLASS("_TtC8xLib60003Gps")
@interface Gps : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_DEPRECATED_MSG("-init is unavailable");
@end


@interface Gps (SWIFT_EXTENSION(xLib6000))
@property (nonatomic, readonly, copy) NSString * _Nonnull altitude;
@property (nonatomic, readonly) double frequencyError;
@property (nonatomic, readonly, copy) NSString * _Nonnull grid;
@property (nonatomic, readonly, copy) NSString * _Nonnull latitude;
@property (nonatomic, readonly, copy) NSString * _Nonnull longitude;
@property (nonatomic, readonly, copy) NSString * _Nonnull speed;
@property (nonatomic, readonly) BOOL status;
@property (nonatomic, readonly, copy) NSString * _Nonnull time;
@property (nonatomic, readonly) double track;
@property (nonatomic, readonly) BOOL tracked;
@property (nonatomic, readonly) BOOL visible;
@end


SWIFT_CLASS("_TtC8xLib60009Interlock")
@interface Interlock : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_DEPRECATED_MSG("-init is unavailable");
@end


@interface Interlock (SWIFT_EXTENSION(xLib6000))
@property (nonatomic) BOOL accTxEnabled;
@property (nonatomic) NSInteger accTxDelay;
@property (nonatomic) BOOL accTxReqEnabled;
@property (nonatomic) BOOL accTxReqPolarity;
@property (nonatomic) BOOL rcaTxReqEnabled;
@property (nonatomic) BOOL rcaTxReqPolarity;
@property (nonatomic) NSInteger timeout;
@property (nonatomic) NSInteger txDelay;
@property (nonatomic) BOOL tx1Enabled;
@property (nonatomic) NSInteger tx1Delay;
@property (nonatomic) BOOL tx2Enabled;
@property (nonatomic) NSInteger tx2Delay;
@property (nonatomic) BOOL tx3Enabled;
@property (nonatomic) NSInteger tx3Delay;
@end


@interface Interlock (SWIFT_EXTENSION(xLib6000))
@property (nonatomic, readonly, copy) NSString * _Nonnull reason;
@property (nonatomic, readonly, copy) NSString * _Nonnull source;
@property (nonatomic, readonly, copy) NSString * _Nonnull amplifier;
@property (nonatomic, readonly, copy) NSString * _Nonnull state;
@property (nonatomic, readonly) BOOL txAllowed;
@end


SWIFT_CLASS("_TtC8xLib60008IqStream")
@interface IqStream : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_DEPRECATED_MSG("-init is unavailable");
@end


@interface IqStream (SWIFT_EXTENSION(xLib6000))
@property (nonatomic) NSInteger rate;
@end


@interface IqStream (SWIFT_EXTENSION(xLib6000))
@property (nonatomic, readonly) NSInteger available;
@property (nonatomic, readonly) NSInteger capacity;
@property (nonatomic, readonly) NSInteger daxIqChannel;
@property (nonatomic, readonly) BOOL inUse;
@property (nonatomic, readonly, copy) NSString * _Nonnull ip;
@property (nonatomic, readonly) NSInteger port;
@property (nonatomic, readonly) uint32_t pan;
@property (nonatomic, readonly) BOOL streaming;
@end


SWIFT_CLASS("_TtC8xLib60006Memory")
@interface Memory : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_DEPRECATED_MSG("-init is unavailable");
@end




@interface Memory (SWIFT_EXTENSION(xLib6000))
@property (nonatomic) NSInteger digitalLowerOffset;
@property (nonatomic) NSInteger digitalUpperOffset;
@property (nonatomic) NSInteger filterHigh;
@property (nonatomic) NSInteger filterLow;
@property (nonatomic) NSInteger frequency;
@property (nonatomic, copy) NSString * _Nonnull group;
@property (nonatomic, copy) NSString * _Nonnull mode;
@property (nonatomic, copy) NSString * _Nonnull name;
@property (nonatomic) NSInteger offset;
@property (nonatomic, copy) NSString * _Nonnull offsetDirection;
@property (nonatomic, copy) NSString * _Nonnull owner;
@property (nonatomic) NSInteger rfPower;
@property (nonatomic) NSInteger rttyMark;
@property (nonatomic) NSInteger rttyShift;
@property (nonatomic) BOOL squelchEnabled;
@property (nonatomic) NSInteger squelchLevel;
@property (nonatomic) NSInteger step;
@property (nonatomic, copy) NSString * _Nonnull toneMode;
@property (nonatomic) NSInteger toneValue;
@end


SWIFT_CLASS("_TtC8xLib60005Meter")
@interface Meter : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_DEPRECATED_MSG("-init is unavailable");
@end




@interface Meter (SWIFT_EXTENSION(xLib6000))
@property (nonatomic, copy) NSString * _Nonnull desc;
@property (nonatomic) NSInteger fps;
@property (nonatomic) float high;
@property (nonatomic) float low;
@property (nonatomic, copy) NSString * _Nonnull name;
@property (nonatomic, copy) NSString * _Nonnull number;
@property (nonatomic) float peak;
@property (nonatomic, copy) NSString * _Nonnull source;
@property (nonatomic, copy) NSString * _Nonnull units;
@property (nonatomic) float value;
@end


SWIFT_CLASS("_TtC8xLib600014MicAudioStream")
@interface MicAudioStream : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_DEPRECATED_MSG("-init is unavailable");
@end




@interface MicAudioStream (SWIFT_EXTENSION(xLib6000))
@property (nonatomic, readonly) BOOL inUse;
@property (nonatomic, copy) NSString * _Nonnull ip;
@property (nonatomic) NSInteger port;
@property (nonatomic) NSInteger micGain;
@end




SWIFT_CLASS("_TtC8xLib60004Opus")
@interface Opus : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_DEPRECATED_MSG("-init is unavailable");
@end


@interface Opus (SWIFT_EXTENSION(xLib6000))
@property (nonatomic) BOOL rxEnabled;
@property (nonatomic) BOOL txEnabled;
@end


@interface Opus (SWIFT_EXTENSION(xLib6000))
@property (nonatomic) uint32_t clientHandle;
@property (nonatomic, copy) NSString * _Nonnull ip;
@property (nonatomic) NSInteger port;
@property (nonatomic) BOOL rxStopped;
@end


SWIFT_CLASS("_TtC8xLib600010Panadapter")
@interface Panadapter : NSObject
@property (nonatomic, readonly, copy) NSArray<NSString *> * _Nonnull daxIqChoices;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_DEPRECATED_MSG("-init is unavailable");
@end


@interface Panadapter (SWIFT_EXTENSION(xLib6000))
@property (nonatomic) NSInteger average;
@property (nonatomic, copy) NSString * _Nonnull band;
@property (nonatomic) NSInteger bandwidth;
@property (nonatomic) BOOL bandZoomEnabled;
@property (nonatomic) NSInteger center;
@property (nonatomic) NSInteger daxIqChannel;
@property (nonatomic) NSInteger fps;
@property (nonatomic) BOOL loggerDisplayEnabled;
@property (nonatomic, copy) NSString * _Nonnull loggerDisplayIpAddress;
@property (nonatomic) NSInteger loggerDisplayPort;
@property (nonatomic) NSInteger loggerDisplayRadioNumber;
@property (nonatomic) BOOL loopAEnabled;
@property (nonatomic) BOOL loopBEnabled;
@property (nonatomic) CGFloat maxDbm;
@property (nonatomic) CGFloat minDbm;
@property (nonatomic) NSInteger rfGain;
@property (nonatomic, copy) NSString * _Nonnull rxAnt;
@property (nonatomic) BOOL segmentZoomEnabled;
@property (nonatomic) BOOL weightedAverageEnabled;
@property (nonatomic) BOOL wnbEnabled;
@property (nonatomic) NSInteger wnbLevel;
@property (nonatomic) CGFloat xPixels;
@property (nonatomic) CGFloat yPixels;
@end


@interface Panadapter (SWIFT_EXTENSION(xLib6000))
@property (nonatomic, readonly, copy) NSArray<NSString *> * _Nonnull antList;
@property (nonatomic, readonly) NSInteger maxBw;
@property (nonatomic, readonly) NSInteger minBw;
@property (nonatomic, readonly, copy) NSString * _Nonnull preamp;
@property (nonatomic, readonly) NSInteger rfGainHigh;
@property (nonatomic, readonly) NSInteger rfGainLow;
@property (nonatomic, readonly) NSInteger rfGainStep;
@property (nonatomic, readonly, copy) NSString * _Nonnull rfGainValues;
@property (nonatomic, readonly) uint32_t waterfallId;
@property (nonatomic, readonly) BOOL wide;
@property (nonatomic, readonly) BOOL wnbUpdating;
@property (nonatomic, readonly, copy) NSString * _Nonnull xvtrLabel;
@end


SWIFT_CLASS("_TtC8xLib60007Profile")
@interface Profile : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_DEPRECATED_MSG("-init is unavailable");
@end


@interface Profile (SWIFT_EXTENSION(xLib6000))
@property (nonatomic, copy) NSString * _Nonnull selection;
@end


@interface Profile (SWIFT_EXTENSION(xLib6000))
@property (nonatomic, readonly, copy) NSArray<NSString *> * _Nonnull list;
@end

@class Transmit;
@class Wan;
@class Waveform;

SWIFT_CLASS("_TtC8xLib60005Radio")
@interface Radio : NSObject
@property (nonatomic, readonly, copy) NSString * _Nonnull version;
@property (nonatomic, readonly, copy) NSString * _Nonnull serialNumber;
@property (nonatomic, readonly, strong) Atu * _Null_unspecified atu;
@property (nonatomic, readonly, strong) Cwx * _Null_unspecified cwx;
@property (nonatomic, readonly, strong) Gps * _Null_unspecified gps;
@property (nonatomic, readonly, strong) Interlock * _Null_unspecified interlock;
@property (nonatomic, readonly, strong) Profile * _Null_unspecified profile;
@property (nonatomic, readonly, strong) Transmit * _Null_unspecified transmit;
@property (nonatomic, readonly, strong) Wan * _Null_unspecified wan;
@property (nonatomic, readonly, strong) Waveform * _Null_unspecified waveform;
@property (nonatomic, readonly, copy) NSArray<NSString *> * _Nonnull antennaList;
@property (nonatomic, readonly, copy) NSArray<NSString *> * _Nonnull micList;
@property (nonatomic, readonly, copy) NSArray<NSString *> * _Nonnull rfGainList;
@property (nonatomic, readonly, copy) NSArray<NSString *> * _Nonnull sliceList;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_DEPRECATED_MSG("-init is unavailable");
@end


@interface Radio (SWIFT_EXTENSION(xLib6000))
@property (nonatomic) BOOL apfEnabled;
@property (nonatomic) NSInteger apfQFactor;
@property (nonatomic) NSInteger apfGain;
@property (nonatomic) NSInteger headphoneGain;
@property (nonatomic) BOOL headphoneMute;
@property (nonatomic) NSInteger lineoutGain;
@property (nonatomic) BOOL lineoutMute;
@property (nonatomic) BOOL bandPersistenceEnabled;
@property (nonatomic) BOOL binauralRxEnabled;
@property (nonatomic) NSInteger calFreq;
@property (nonatomic) BOOL enforcePrivateIpEnabled;
@property (nonatomic) NSInteger freqErrorPpb;
@property (nonatomic) BOOL frontSpeakerMute;
@property (nonatomic) BOOL fullDuplexEnabled;
@property (nonatomic) BOOL remoteOnEnabled;
@property (nonatomic) NSInteger rttyMark;
@property (nonatomic) BOOL snapTuneEnabled;
@property (nonatomic) BOOL tnfsEnabled;
@property (nonatomic) NSInteger backlight;
@property (nonatomic) BOOL startCalibration;
@property (nonatomic, copy) NSString * _Nonnull callsign;
@property (nonatomic) BOOL muteLocalAudio;
@property (nonatomic, copy) NSString * _Nonnull nickname;
@property (nonatomic, copy) NSString * _Nonnull radioScreenSaver;
@property (nonatomic) BOOL filterCwAutoEnabled;
@property (nonatomic) BOOL filterDigitalAutoEnabled;
@property (nonatomic) BOOL filterVoiceAutoEnabled;
@property (nonatomic) NSInteger filterCwLevel;
@property (nonatomic) NSInteger filterDigitalLevel;
@property (nonatomic) NSInteger filterVoiceLevel;
@property (nonatomic, copy) NSString * _Nonnull staticGateway;
@property (nonatomic, copy) NSString * _Nonnull staticIp;
@property (nonatomic, copy) NSString * _Nonnull staticNetmask;
@property (nonatomic) BOOL mox;
@end


@interface Radio (SWIFT_EXTENSION(xLib6000))
@property (nonatomic, readonly) BOOL atuPresent;
@property (nonatomic, readonly) NSInteger availablePanadapters;
@property (nonatomic, readonly) NSInteger availableSlices;
@property (nonatomic, readonly, copy) NSString * _Nonnull chassisSerial;
@property (nonatomic, readonly, copy) NSString * _Nonnull clientIp;
@property (nonatomic, readonly) NSInteger daxIqAvailable;
@property (nonatomic, readonly) NSInteger daxIqCapacity;
@property (nonatomic, readonly) BOOL extPresent;
@property (nonatomic, readonly, copy) NSString * _Nonnull fpgaMbVersion;
@property (nonatomic, readonly, copy) NSString * _Nonnull gateway;
@property (nonatomic, readonly) BOOL gpsPresent;
@property (nonatomic, readonly) BOOL gpsdoPresent;
@property (nonatomic, readonly, copy) NSString * _Nonnull ipAddress;
@property (nonatomic, readonly, copy) NSString * _Nonnull location;
@property (nonatomic, readonly) BOOL locked;
@property (nonatomic, readonly, copy) NSString * _Nonnull macAddress;
@property (nonatomic, readonly, copy) NSString * _Nonnull netmask;
@property (nonatomic, readonly) NSInteger numberOfScus;
@property (nonatomic, readonly) NSInteger numberOfSlices;
@property (nonatomic, readonly) NSInteger numberOfTx;
@property (nonatomic, readonly, copy) NSString * _Nonnull picDecpuVersion;
@property (nonatomic, readonly, copy) NSString * _Nonnull psocMbPa100Version;
@property (nonatomic, readonly, copy) NSString * _Nonnull psocMbtrxVersion;
@property (nonatomic, readonly, copy) NSString * _Nonnull radioModel;
@property (nonatomic, readonly, copy) NSString * _Nonnull radioOptions;
@property (nonatomic, readonly, copy) NSString * _Nonnull region;
@property (nonatomic, readonly, copy) NSString * _Nonnull setting;
@property (nonatomic, readonly, copy) NSString * _Nonnull smartSdrMB;
@property (nonatomic, readonly, copy) NSString * _Nonnull state;
@property (nonatomic, readonly, copy) NSString * _Nonnull softwareVersion;
@property (nonatomic, readonly) BOOL tcxoPresent;
@end

@class GCDAsyncUdpSocket;

SWIFT_CLASS("_TtC8xLib600012RadioFactory")
@interface RadioFactory : NSObject <GCDAsyncUdpSocketDelegate>
/// The Socket received data
/// \param sock the GCDAsyncUdpSocket
///
/// \param data the Data received
///
/// \param address the Address of the sender
///
/// \param filterContext the FilterContext
///
- (void)udpSocket:(GCDAsyncUdpSocket * _Nonnull)sock didReceiveData:(NSData * _Nonnull)data fromAddress:(NSData * _Nonnull)address withFilterContext:(id _Nullable)filterContext;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_DEPRECATED_MSG("-init is unavailable");
@end


SWIFT_CLASS("_TtC8xLib60005Slice")
@interface Slice : NSObject
@property (nonatomic, copy) NSArray<NSString *> * _Nonnull agcNames;
@property (nonatomic, readonly, copy) NSArray<NSString *> * _Nonnull daxChoices;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_DEPRECATED_MSG("-init is unavailable");
@end


@interface Slice (SWIFT_EXTENSION(xLib6000))
@property (nonatomic) NSInteger audioGain;
@property (nonatomic) BOOL audioMute;
@property (nonatomic) NSInteger audioPan;
@property (nonatomic) NSInteger filterHigh;
@property (nonatomic) NSInteger filterLow;
@property (nonatomic) BOOL locked;
@property (nonatomic) BOOL active;
@property (nonatomic, copy) NSString * _Nonnull agcMode;
@property (nonatomic) NSInteger agcOffLevel;
@property (nonatomic) NSInteger agcThreshold;
@property (nonatomic) BOOL anfEnabled;
@property (nonatomic) NSInteger anfLevel;
@property (nonatomic) BOOL apfEnabled;
@property (nonatomic) NSInteger apfLevel;
@property (nonatomic) NSInteger daxChannel;
@property (nonatomic) BOOL dfmPreDeEmphasisEnabled;
@property (nonatomic) NSInteger digitalLowerOffset;
@property (nonatomic) NSInteger digitalUpperOffset;
@property (nonatomic) BOOL diversityEnabled;
@property (nonatomic) NSInteger fmDeviation;
@property (nonatomic) float fmRepeaterOffset;
@property (nonatomic) BOOL fmToneBurstEnabled;
@property (nonatomic) float fmToneFreq;
@property (nonatomic, copy) NSString * _Nonnull fmToneMode;
@property (nonatomic) BOOL loopAEnabled;
@property (nonatomic) BOOL loopBEnabled;
@property (nonatomic, copy) NSString * _Nonnull mode;
@property (nonatomic) BOOL nbEnabled;
@property (nonatomic) NSInteger nbLevel;
@property (nonatomic) BOOL nrEnabled;
@property (nonatomic) NSInteger nrLevel;
@property (nonatomic) BOOL playbackEnabled;
@property (nonatomic) BOOL recordEnabled;
@property (nonatomic, copy) NSString * _Nonnull repeaterOffsetDirection;
@property (nonatomic) NSInteger rfGain;
@property (nonatomic) BOOL ritEnabled;
@property (nonatomic) NSInteger ritOffset;
@property (nonatomic) NSInteger rttyMark;
@property (nonatomic) NSInteger rttyShift;
@property (nonatomic, copy) NSString * _Nonnull rxAnt;
@property (nonatomic) NSInteger step;
@property (nonatomic, copy) NSString * _Nonnull stepList;
@property (nonatomic) BOOL squelchEnabled;
@property (nonatomic) NSInteger squelchLevel;
@property (nonatomic, copy) NSString * _Nonnull txAnt;
@property (nonatomic) BOOL txEnabled;
@property (nonatomic) float txOffsetFreq;
@property (nonatomic) BOOL wnbEnabled;
@property (nonatomic) NSInteger wnbLevel;
@property (nonatomic) BOOL xitEnabled;
@property (nonatomic) NSInteger xitOffset;
@property (nonatomic) NSInteger frequency;
@end


@interface Slice (SWIFT_EXTENSION(xLib6000))
@property (nonatomic) BOOL autoPan;
@property (nonatomic) NSInteger daxClients;
@property (nonatomic) BOOL daxTxEnabled;
@property (nonatomic) BOOL detached;
@property (nonatomic) BOOL diversityChild;
@property (nonatomic) NSInteger diversityIndex;
@property (nonatomic) BOOL diversityParent;
@property (nonatomic, readonly) BOOL inUse;
@property (nonatomic, copy) NSArray<NSString *> * _Nonnull modeList;
@property (nonatomic) NSInteger nr2;
@property (nonatomic) NSInteger owner;
@property (nonatomic) uint32_t panadapterId;
@property (nonatomic) BOOL postDemodBypassEnabled;
@property (nonatomic) NSInteger postDemodHigh;
@property (nonatomic) NSInteger postDemodLow;
@property (nonatomic) BOOL qskEnabled;
@property (nonatomic) float recordLength;
@property (nonatomic, copy) NSArray<NSString *> * _Nonnull rxAntList;
@property (nonatomic, copy) NSArray<NSString *> * _Nonnull txAntList;
@property (nonatomic) BOOL wide;
@property (nonatomic, copy) NSDictionary<NSString *, Meter *> * _Nonnull meters;
@end


SWIFT_CLASS("_TtC8xLib60003Tnf")
@interface Tnf : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_DEPRECATED_MSG("-init is unavailable");
@end




@interface Tnf (SWIFT_EXTENSION(xLib6000))
@property (nonatomic) NSInteger depth;
@property (nonatomic) NSInteger frequency;
@property (nonatomic) BOOL permanent;
@property (nonatomic) NSInteger width;
@end


SWIFT_CLASS("_TtC8xLib60008Transmit")
@interface Transmit : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_DEPRECATED_MSG("-init is unavailable");
@end


@interface Transmit (SWIFT_EXTENSION(xLib6000))
@property (nonatomic) NSInteger cwBreakInDelay;
@property (nonatomic) BOOL cwBreakInEnabled;
@property (nonatomic) BOOL cwIambicEnabled;
@property (nonatomic) NSInteger cwIambicMode;
@property (nonatomic) BOOL cwlEnabled;
@property (nonatomic) NSInteger cwPitch;
@property (nonatomic) BOOL cwSidetoneEnabled;
@property (nonatomic) NSInteger cwSpeed;
@property (nonatomic) BOOL cwSwapPaddles;
@property (nonatomic) BOOL cwSyncCwxEnabled;
@property (nonatomic) NSInteger cwWeight;
@property (nonatomic) BOOL micAccEnabled;
@property (nonatomic) BOOL micBiasEnabled;
@property (nonatomic) BOOL micBoostEnabled;
@property (nonatomic, copy) NSString * _Nonnull micSelection;
@property (nonatomic) NSInteger carrierLevel;
@property (nonatomic) BOOL companderEnabled;
@property (nonatomic) NSInteger companderLevel;
@property (nonatomic) BOOL cwAutoSpaceEnabled;
@property (nonatomic) BOOL daxEnabled;
@property (nonatomic) BOOL hwAlcEnabled;
@property (nonatomic) BOOL inhibit;
@property (nonatomic) NSInteger maxPowerLevel;
@property (nonatomic) BOOL metInRxEnabled;
@property (nonatomic) NSInteger micLevel;
@property (nonatomic) NSInteger rfPower;
@property (nonatomic) BOOL speechProcessorEnabled;
@property (nonatomic) NSInteger speechProcessorLevel;
@property (nonatomic) BOOL ssbPeakControlEnabled;
@property (nonatomic) NSInteger tunePower;
@property (nonatomic) NSInteger txFilterHigh;
@property (nonatomic) NSInteger txFilterLow;
@property (nonatomic) BOOL txInWaterfallEnabled;
@property (nonatomic) BOOL txMonitorEnabled;
@property (nonatomic) NSInteger txMonitorGainCw;
@property (nonatomic) NSInteger txMonitorGainSb;
@property (nonatomic) NSInteger txMonitorPanCw;
@property (nonatomic) NSInteger txMonitorPanSb;
@property (nonatomic) BOOL voxEnabled;
@property (nonatomic) NSInteger voxDelay;
@property (nonatomic) NSInteger voxLevel;
@property (nonatomic) BOOL tune;
@end


@interface Transmit (SWIFT_EXTENSION(xLib6000))
@property (nonatomic) NSInteger frequency;
@property (nonatomic, readonly) BOOL rawIqEnabled;
@property (nonatomic, readonly) BOOL txFilterChanges;
@property (nonatomic, readonly) BOOL txMonitorAvailable;
@property (nonatomic, readonly) BOOL txRfPowerChanges;
@end


SWIFT_CLASS("_TtC8xLib600013TxAudioStream")
@interface TxAudioStream : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_DEPRECATED_MSG("-init is unavailable");
@end


@interface TxAudioStream (SWIFT_EXTENSION(xLib6000))
@property (nonatomic) BOOL transmit;
@end


@interface TxAudioStream (SWIFT_EXTENSION(xLib6000))
@property (nonatomic, readonly) BOOL inUse;
@property (nonatomic, copy) NSString * _Nonnull ip;
@property (nonatomic) NSInteger port;
@property (nonatomic) NSInteger txGain;
@end


SWIFT_CLASS("_TtC8xLib60008UsbCable")
@interface UsbCable : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_DEPRECATED_MSG("-init is unavailable");
@end




@interface UsbCable (SWIFT_EXTENSION(xLib6000))
@property (nonatomic) BOOL autoReport;
@property (nonatomic, copy) NSString * _Nonnull band;
@property (nonatomic) NSInteger dataBits;
@property (nonatomic) BOOL enable;
@property (nonatomic, copy) NSString * _Nonnull flowControl;
@property (nonatomic, copy) NSString * _Nonnull name;
@property (nonatomic, copy) NSString * _Nonnull parity;
@property (nonatomic) BOOL pluggedIn;
@property (nonatomic, copy) NSString * _Nonnull polarity;
@property (nonatomic, copy) NSString * _Nonnull preamp;
@property (nonatomic, copy) NSString * _Nonnull source;
@property (nonatomic, copy) NSString * _Nonnull sourceRxAnt;
@property (nonatomic) NSInteger sourceSlice;
@property (nonatomic, copy) NSString * _Nonnull sourceTxAnt;
@property (nonatomic) NSInteger speed;
@property (nonatomic) NSInteger stopBits;
@property (nonatomic) BOOL usbLog;
@end


SWIFT_CLASS("_TtC8xLib60003Wan")
@interface Wan : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_DEPRECATED_MSG("-init is unavailable");
@end


@interface Wan (SWIFT_EXTENSION(xLib6000))
@property (nonatomic, readonly) BOOL radioAuthenticated;
@property (nonatomic, readonly) BOOL serverConnected;
@end

@class GCDAsyncSocket;

SWIFT_CLASS("_TtC8xLib60009WanServer")
@interface WanServer : NSObject <GCDAsyncSocketDelegate>
/// Called when the TCP/IP connection has been disconnected
/// \param sock the disconnected socket
///
/// \param err the error
///
- (void)socketDidDisconnect:(GCDAsyncSocket * _Nonnull)sock withError:(NSError * _Nullable)err;
/// Called after the TCP/IP connection has been established
/// \param sock the socket
///
/// \param host the host
///
/// \param port the port
///
- (void)socket:(GCDAsyncSocket * _Nonnull)sock didConnectToHost:(NSString * _Nonnull)host port:(uint16_t)port;
/// Called when data has been read from the TCP/IP connection
/// \param sock the socket data was received on
///
/// \param data the Data
///
/// \param tag the Tag associated with this receipt
///
- (void)socket:(GCDAsyncSocket * _Nonnull)sock didReadData:(NSData * _Nonnull)data withTag:(NSInteger)tag;
/// Called after the socket has successfully completed SSL/TLS negotiation.
/// This method is not called unless you use the provided startTLS method.
/// If a SSL/TLS negotiation fails (invalid certificate, etc) then the socket will immediately close,
/// and the socketDidDisconnect:withError: delegate method will be called with the specific SSL error code.
/// <ul>
///   <li>
///   </li>
/// </ul>
/// Called after the socket has successfully completed SSL/TLS negotiation
/// \param sock the socket
///
- (void)socketDidSecure:(GCDAsyncSocket * _Nonnull)sock;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_DEPRECATED_MSG("-init is unavailable");
@end




@interface WanServer (SWIFT_EXTENSION(xLib6000))
@property (nonatomic, readonly) BOOL isConnected;
@property (nonatomic, readonly, copy) NSString * _Nonnull sslClientPublicIp;
@end


SWIFT_CLASS("_TtC8xLib60009Waterfall")
@interface Waterfall : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_DEPRECATED_MSG("-init is unavailable");
@end


@interface Waterfall (SWIFT_EXTENSION(xLib6000))
@property (nonatomic) BOOL autoBlackEnabled;
@property (nonatomic) NSInteger blackLevel;
@property (nonatomic) NSInteger colorGain;
@property (nonatomic) NSInteger gradientIndex;
@property (nonatomic) NSInteger lineDuration;
@end


@interface Waterfall (SWIFT_EXTENSION(xLib6000))
@property (nonatomic, readonly) uint32_t autoBlackLevel;
@property (nonatomic, readonly) uint32_t panadapterId;
@end


SWIFT_CLASS("_TtC8xLib60008Waveform")
@interface Waveform : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_DEPRECATED_MSG("-init is unavailable");
@end


@interface Waveform (SWIFT_EXTENSION(xLib6000))
@property (nonatomic, readonly, copy) NSString * _Nonnull waveformList;
@end


SWIFT_CLASS("_TtC8xLib60004Xvtr")
@interface Xvtr : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_DEPRECATED_MSG("-init is unavailable");
@end


@interface Xvtr (SWIFT_EXTENSION(xLib6000))
@property (nonatomic) NSInteger ifFrequency;
@property (nonatomic) NSInteger loError;
@property (nonatomic, copy) NSString * _Nonnull name;
@property (nonatomic) NSInteger maxPower;
@property (nonatomic) NSInteger order;
@property (nonatomic) NSInteger rfFrequency;
@property (nonatomic) NSInteger rxGain;
@property (nonatomic) BOOL rxOnly;
@end


@interface Xvtr (SWIFT_EXTENSION(xLib6000))
@property (nonatomic, readonly) BOOL inUse;
@property (nonatomic, readonly) BOOL isValid;
@property (nonatomic, readonly) BOOL preferred;
@property (nonatomic, readonly) NSInteger twoMeterInt;
@end

#if __has_attribute(external_source_symbol)
# pragma clang attribute pop
#endif
#pragma clang diagnostic pop
