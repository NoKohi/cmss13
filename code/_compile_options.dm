#ifndef PRELOAD_RSC //set to:
#define PRELOAD_RSC 1 // 0 to allow using external resources or on-demand behaviour;
#endif // 1 to use the default behaviour;
								// 2 for preloading absolutely everything;

// If this is uncommented, will attempt to load prof.dll (windows) or libprof.so (unix)
// byond-tracy is not shipped with CM code. Build it yourself here: https://github.com/mafemergency/byond-tracy/
//#define BYOND_TRACY
