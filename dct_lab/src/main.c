#include "gama.h"
#include "physics.h"
#include "key.h"
#include "widgets/button.h"

int main() {
  // Initialize with window size and title
  gm_init(800, 600, "My Game");
  gm_background(GM_BLACK);

  // Create a physics body
  gmBody player = gm_circle_body(1.0, 400, 300, 32);
  player.acceleration.y = 0.9;

  // Game loop
  do {
    // update position
    gm_body_update(&player);
    // Handle input
    if (gm_key('L')) player.velocity.x -= 0.1;  // Move left
    if (gm_key('R')) player.velocity.x += 0.1;  // Move right

    if(gm_mouse.clicked && gmw_button(0, 0.9, 0.3, 0.1, "jump", 0.1))
      player.velocity.y  += 1;


    // Draw elements
    gm_draw_circle_body(&player, GM_BLUE);

    // Check for exit condition
    if (gm_key('E'))
      gm_quit();
  } while (gm_yield());

  return 0;
}