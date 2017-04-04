# Configuration

## IConfiguration implementations

### BasicConfiguration

Easiest way to create your own configuration is to extend *BasicConfiguration*.

### TraceEverythingConfiguration

The simplest predefined configuration to get some log visible. This configuration add TraceLogTarget and sets *root* logger to `LogLevel.ALL`.

### MacroConfiguration

Variation of the `TraceEverythingConfiguration` but uses `MacroLogLayout` instead of the default trace layout.
