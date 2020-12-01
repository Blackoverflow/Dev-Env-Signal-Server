package org.whispersystems.textsecuregcm.auth;

import java.util.UUID;

public class AmbiguousIdentifier {

  private final UUID   uuid;
  private final String number;

  public AmbiguousIdentifier(String target) {
    if (target.matches("^[0-9a-f]{8}-([0-9a-f]{4}-){3}[0-9a-f]{12}$")) {
      this.uuid   = UUID.fromString(target);
      this.number = null;
    } else {
      this.uuid   = null;
      this.number = target;
    }
  }

  // public AmbiguousIdentifier(String target) {
  //   if (target.startsWith("+")) {
  //     this.uuid   = null;
  //     this.number = target;
  //   } else {
  //     this.uuid   = UUID.fromString(target);
  //     this.number = null;
  //   }
  // }

  public UUID getUuid() {
    return uuid;
  }

  public String getNumber() {
    return number;
  }

  public boolean hasUuid() {
    return uuid != null;
  }

  public boolean hasNumber() {
    return number != null;
  }
}
